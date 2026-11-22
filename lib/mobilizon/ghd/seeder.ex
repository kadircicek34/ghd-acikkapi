defmodule Mobilizon.GHD.Seeder do
  @moduledoc """
  Idempotent local seed for the GHD Açık Kapı instance.

  It creates the administrator account, the organiser profile and the single
  half-day guest-visit listing. It never overwrites an existing listing, so it
  is safe to run more than once.
  """

  alias Mobilizon.Actors
  alias Mobilizon.Actors.Actor
  alias Mobilizon.Events
  alias Mobilizon.Users
  alias Mobilizon.Users.User

  require Logger

  @event_uuid "a1111111-1111-4111-8111-111111111111"
  @actor_username "ghdacikkapi"

  @spec run() :: :ok
  def run do
    admin = ensure_admin()
    actor = ensure_actor(admin)
    event = ensure_event(actor)

    IO.puts("GHD seed ready")
    IO.puts("  admin: #{admin.email}")
    IO.puts("  event: #{event.title}")
    IO.puts("  uuid:  #{event.uuid}")
    :ok
  end

  defp ensure_admin do
    email = System.get_env("GHD_ADMIN_EMAIL", "admin@acikkapi.local")
    password = System.get_env("GHD_ADMIN_PASSWORD", "GHD-AcikKapi-Local-2026!")

    case Users.get_user_by_email(email) do
      {:ok, %User{} = user} ->
        if user.role != :administrator do
          {:ok, user} = Users.update_user(user, %{role: :administrator})
          user
        else
          user
        end

      {:error, :user_not_found} ->
        {:ok, %User{} = user} =
          Users.register(%{
            email: email,
            password: password,
            role: :administrator,
            confirmed_at: DateTime.utc_now() |> DateTime.truncate(:second),
            confirmation_sent_at: nil,
            confirmation_token: nil
          })

        user

      {:error, :user_pending} ->
        {:ok, user} = Users.get_user_by_email(email, unconfirmed: true)
        {:ok, user} = Users.update_user(user, %{role: :administrator})
        user
    end
  end

  defp ensure_actor(%User{id: user_id}) do
    case Actors.get_local_actor_by_name(@actor_username) do
      %Actor{} = actor ->
        actor

      nil ->
        {:ok, %Actor{} = actor} =
          Actors.new_person(
            %{
              preferred_username: @actor_username,
              name: "GHD Açık Kapı",
              summary:
                "Global Hukukçular Derneği'nin hukuk öğrencileri ve yeni mezunlar için yarım günlük misafirlik programı.",
              user_id: user_id,
              type: :Person,
              visibility: :public
            },
            true
          )

        actor
    end
  end

  defp ensure_event(%Actor{} = actor) do
    case Events.get_event_by_uuid_with_preload(@event_uuid) do
      %Mobilizon.Events.Event{} = event ->
        event

      nil ->
        begins_on = next_wednesday_at_14_istanbul()
        ends_on = DateTime.add(begins_on, 4 * 60 * 60, :second)

        attrs = %{
          uuid: @event_uuid,
          title: "Yarım Günlük Hukuk Misafirliği",
          description: """
          <p><strong>GHD Açık Kapı</strong>, hukuk öğrencileri ve yeni mezunlar için bir hukuk bürosunda veya şirketin hukuk ekibinde <strong>yarım günlük misafirlik</strong> imkânı sunar.</p>
          <p>Misafirlik boyunca hukuk ekibinin günlük işleyişini gözlemleyecek, dosya akışını ve ekip çalışmasını yakından tanıyacaksınız. Program yüz yüze ve tek oturumluktur.</p>
          <ul>
            <li><strong>Kontenjan:</strong> 3 kişi</li>
            <li><strong>Süre:</strong> Yarım gün (yaklaşık 4 saat)</li>
            <li><strong>Kimler başvurabilir:</strong> Hukuk fakültesi öğrencileri ve yeni mezunlar</li>
            <li><strong>Başvuru:</strong> Hesap açmadan, kısa bir motivasyon notuyla</li>
          </ul>
          <p>Başvurunuz önce e-posta ile doğrulanır, ardından dernek tarafından manuel olarak değerlendirilir. Başvuruların onaylanmasıyla kontenjan dolar.</p>
          """
          |> String.trim(),
          begins_on: begins_on,
          ends_on: ends_on,
          organizer_actor_id: actor.id,
          category: "LEARNING",
          visibility: :public,
          join_options: :restricted,
          draft: false,
          local: true,
          language: "tr",
          publish_at: DateTime.utc_now() |> DateTime.truncate(:second),
          physical_address: %{
            description: "GHD Hukuk Bürosu",
            street: "Kızılay",
            locality: "Ankara",
            region: "Ankara",
            country: "Türkiye",
            postal_code: "06420",
            timezone: "Europe/Istanbul",
            geom: %Geo.Point{coordinates: {32.8597, 39.9334}, srid: 4326}
          },
          options: %{
            maximum_attendee_capacity: 3,
            show_remaining_attendee_capacity: true,
            anonymous_participation: true,
            timezone: "Europe/Istanbul",
            hide_number_of_participants: false
          },
          tags: [
            %{title: "Açık Kapı"},
            %{title: "Hukuk"},
            %{title: "Misafirlik"}
          ]
        }

        {:ok, event} = Events.create_event(attrs)
        Logger.info("Created GHD Açık Kapı event #{event.uuid}")
        event
    end
  end

  defp next_wednesday_at_14_istanbul do
    today = Date.utc_today()
    days = Integer.mod(3 - Date.day_of_week(today), 7)
    days = if days == 0, do: 7, else: days
    date = Date.add(today, days)
    {:ok, datetime} = DateTime.new(date, ~T[11:00:00], "Etc/UTC")
    datetime
  end
end
