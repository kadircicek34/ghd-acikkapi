defmodule Mobilizon.GHD.ApplicationFlowTest do
  @moduledoc """
  Domain tests for the GHD Açık Kapı account-only application flow:
  motivation validation, manual approval, rejection and the three-person
  capacity guard.
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
  mutation JoinEvent($actorId: ID!, $eventId: ID!, $message: String) {
    joinEvent(actorId: $actorId, eventId: $eventId, message: $message) {
      id
      role
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
    Config.put([:anonymous, :participation, :allowed], false)
    Config.clear_config_cache()
    on_exit(fn -> Config.clear_config_cache() end)

    organizer = insert(:user, role: :administrator)
    organizer_actor = insert(:actor, user: organizer, name: "GHD Açık Kapı")
    Users.update_user_default_actor(organizer, organizer_actor)

    event =
      insert(:event,
        organizer_actor: organizer_actor,
        join_options: :restricted,
        options: %{
          anonymous_participation: false,
          maximum_attendee_capacity: 3,
          show_remaining_attendee_capacity: true
        }
      )

    insert(:participant, event: event, actor: organizer_actor, role: :creator)

    applicants =
      for n <- 1..5 do
        user = insert(:user)
        actor = insert(:actor, user: user, name: "Aday #{n}")
        %{user: user, actor: actor, number: n}
      end

    {:ok,
     conn: conn,
     event: event,
     organizer: organizer,
     organizer_actor: organizer_actor,
     applicants: applicants}
  end

  test "motivation is required for restricted events", %{
    conn: conn,
    event: event,
    applicants: [applicant | _]
  } do
    res =
      conn
      |> auth_conn(applicant.user)
      |> graphql_query(
        query: @join_mutation,
        variables: %{actorId: applicant.actor.id, eventId: event.id, message: "kısa"}
      )

    assert hd(res["errors"])["message"] =~ "motivation note"
    assert participant_count(event) == 1
  end

  test "approved members can apply, are moderated and capacity is enforced", %{
    conn: conn,
    event: event,
    organizer: organizer,
    applicants: applicants
  } do
    participants =
      Enum.map(applicants, fn applicant ->
        res =
          conn
          |> auth_conn(applicant.user)
          |> graphql_query(
            query: @join_mutation,
            variables: %{
              actorId: applicant.actor.id,
              eventId: event.id,
              message:
                "Hukuk bürosunun günlük işleyişini yerinde görmek istiyorum. Başvuru #{applicant.number}."
            }
          )

        assert res["errors"] == nil
        assert res["data"]["joinEvent"]["role"] == "NOT_APPROVED"
        participant_for(event, applicant.actor.id)
      end)

    assert length(Enum.uniq_by(participants, & &1.id)) == 5

    # The organizer rejects one application.
    rejected = List.last(participants)

    res =
      conn
      |> auth_conn(organizer)
      |> graphql_query(
        query: @update_mutation,
        variables: %{id: rejected.id, role: "REJECTED"}
      )

    assert res["errors"] == nil
    assert res["data"]["updateParticipation"]["role"] == "REJECTED"

    # Three approvals fill the listing.
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

    # The fourth pending application cannot be approved.
    res =
      conn
      |> auth_conn(organizer)
      |> graphql_query(
        query: @update_mutation,
        variables: %{id: d.id, role: "PARTICIPANT"}
      )

    assert res["errors"] != nil
    assert hd(res["errors"])["message"] =~ "maximum capacity"
    assert Repo.get!(Participant, d.id).role == :not_approved
    assert Events.count_participant_participants(event.id) == 3
  end

  defp participant_count(event) do
    Repo.aggregate(from(p in Participant, where: p.event_id == ^event.id), :count)
  end

  defp participant_for(event, actor_id) do
    Repo.one!(
      from p in Participant,
        where: p.event_id == ^event.id and p.actor_id == ^actor_id
    )
  end
end
