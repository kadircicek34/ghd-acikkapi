defmodule Mobilizon.GHD.ApplicationFlowTest do
  @moduledoc """
  End-to-end domain tests for the GHD Açık Kapı application flow:
  anonymous application, e-mail confirmation, manual approval, rejection and
  the three-person capacity guard.
  """

  use MobilizonWeb.ConnCase
  use Mobilizon.Tests.Helpers

  import Mobilizon.Factory
  import Ecto.Query
  import Mobilizon.GraphQL.AbsintheHelpers

  alias Mobilizon.{Config, Events}
  alias Mobilizon.Events.Participant
  alias Mobilizon.Storage.Repo
  alias Mobilizon.Users

  @join_mutation """
  mutation JoinEvent(
    $actorId: ID!
    $eventId: ID!
    $email: String
    $message: String
    $name: String
    $lawStatus: String
    $kvkkAccepted: Boolean
  ) {
    joinEvent(
      actorId: $actorId
      eventId: $eventId
      email: $email
      message: $message
      name: $name
      lawStatus: $lawStatus
      kvkkAccepted: $kvkkAccepted
    ) {
      id
      role
      metadata {
        name
        lawStatus
        message
      }
    }
  }
  """

  @confirm_mutation """
  mutation Confirm($token: String!) {
    confirmParticipation(confirmationToken: $token) {
      id
      role
      event {
        id
        uuid
      }
    }
  }
  """

  @update_mutation """
  mutation Update($id: ID!, $role: ParticipantRoleEnum!) {
    updateParticipation(id: $id, role: $role) {
      id
      role
    }
  }
  """

  setup %{conn: conn} do
    clear_config([:anonymous, :participation])

    Config.put([:anonymous, :participation, :allowed], true)
    Config.put([:anonymous, :participation, :validation, :email, :enabled], true)
    Config.put([:anonymous, :participation, :validation, :email, :confirmation_required], true)
    Config.clear_config_cache()

    on_exit(fn -> clear_config([:anonymous, :participation]) end)

    organizer = insert(:user)
    organizer_actor = insert(:actor, user: organizer, name: "GHD Açık Kapı")

    Users.update_user_default_actor(organizer, organizer_actor)

    event =
      insert(:event,
        organizer_actor: organizer_actor,
        join_options: :restricted,
        options: %{
          anonymous_participation: true,
          maximum_attendee_capacity: 3,
          show_remaining_attendee_capacity: true
        }
      )

    insert(:participant, event: event, actor: organizer_actor, role: :creator)

    anonymous_actor_id = Config.anonymous_actor_id()

    {:ok,
     conn: conn,
     event: event,
     organizer: organizer,
     organizer_actor: organizer_actor,
     anonymous_actor_id: anonymous_actor_id}
  end

  test "applicant is confirmed, approved and capacity is enforced", %{
    conn: conn,
    event: event,
    organizer: organizer,
    anonymous_actor_id: actor_id
  } do
    applicants = for n <- 1..5, do: applicant(n)

    Enum.each(applicants, fn applicant ->
      res =
        graphql_query(conn,
          query: @join_mutation,
          variables: %{
            actorId: actor_id,
            eventId: event.id,
            email: applicant.email,
            message: applicant.message,
            name: applicant.name,
            lawStatus: "student",
            kvkkAccepted: true
          }
        )

      assert res["errors"] == nil
      assert res["data"]["joinEvent"]["role"] == "NOT_CONFIRMED"
      assert res["data"]["joinEvent"]["metadata"]["name"] == applicant.name
      assert res["data"]["joinEvent"]["metadata"]["lawStatus"] == "student"
    end)

    participants = Enum.map(applicants, &participant_for(event, &1.email))
    assert Enum.all?(participants, &(&1.role == :not_confirmed))
    assert length(Enum.uniq_by(participants, & &1.id)) == 5

    # e-mail confirmation moves the application into the manual review queue
    first = hd(participants)

    res =
      graphql_query(conn,
        query: @confirm_mutation,
        variables: %{token: first.metadata.confirmation_token}
      )

    assert res["errors"] == nil
    assert res["data"]["confirmParticipation"]["role"] == "NOT_APPROVED"
    assert participant_for(event, hd(applicants).email).role == :not_approved

    # rejection is manual and recorded
    last = List.last(participants)

    res =
      conn
      |> auth_conn(organizer)
      |> graphql_query(
        query: @update_mutation,
        variables: %{id: last.id, role: "REJECTED"}
      )

    assert res["errors"] == nil
    assert res["data"]["updateParticipation"]["role"] == "REJECTED"
    assert participant_for(event, List.last(applicants).email).role == :rejected

    # three approvals fill the listing
    [a, b, c, d, _e] = participants

    Enum.each([a, b, c], fn participant ->
      res =
        conn
        |> auth_conn(organizer)
        |> graphql_query(
          query: @update_mutation,
          variables: %{id: participant.id, role: "PARTICIPANT"}
        )

      assert res["errors"] == nil
      assert res["data"]["updateParticipation"]["role"] == "PARTICIPANT"
    end)

    assert Events.count_participant_participants(event.id) == 3

    # the fourth pending application cannot be approved
    res =
      conn
      |> auth_conn(organizer)
      |> graphql_query(
        query: @update_mutation,
        variables: %{id: d.id, role: "PARTICIPANT"}
      )

    assert res["errors"] != nil
    assert hd(res["errors"])["message"] =~ "maximum capacity"
    assert participant_for(event, Enum.at(applicants, 3).email).role == :not_approved
    assert Events.count_participant_participants(event.id) == 3
  end

  test "restricted anonymous application requires the GHD fields", %{
    conn: conn,
    event: event,
    anonymous_actor_id: actor_id
  } do
    res =
      graphql_query(conn,
        query: @join_mutation,
        variables: %{
          actorId: actor_id,
          eventId: event.id,
          email: "eksik@example.com",
          message: "Kısa not"
        }
      )

    assert hd(res["errors"])["message"] == "Please provide your full name"
    assert Repo.aggregate(from(p in Participant, where: p.event_id == ^event.id), :count) == 1
  end

  defp applicant(n) do
    %{
      name: "Aday #{n}",
      email: "aday#{n}@example.com",
      message: "Hukuk bürosunun günlük işleyişini yerinde görmek istiyorum. Başvuru #{n}."
    }
  end

  defp participant_for(event, email) do
    Repo.one!(
      from p in Participant,
        where: p.event_id == ^event.id and fragment("? ->>'email' = ?", p.metadata, ^email)
    )
  end
end
