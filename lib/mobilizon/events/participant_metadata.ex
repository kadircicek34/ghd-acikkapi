defmodule Mobilizon.Events.Participant.Metadata do
  @moduledoc """
  Participation stats on event
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Mobilizon.Web.Email.Checker

  @type t :: %__MODULE__{
          email: String.t(),
          confirmation_token: String.t(),
          cancellation_token: String.t(),
          message: String.t(),
          locale: String.t(),
          name: String.t() | nil,
          law_status: String.t() | nil,
          kvkk_accepted: boolean() | nil
        }

  @attrs [
    :email,
    :confirmation_token,
    :cancellation_token,
    :message,
    :locale,
    :timezone,
    :name,
    :law_status,
    :kvkk_accepted
  ]

  @derive Jason.Encoder
  embedded_schema do
    field(:email, :string)
    field(:confirmation_token, :string)
    field(:cancellation_token, :string)
    field(:message, :string)
    field(:locale, :string)
    field(:timezone, :string)
    field(:name, :string)
    field(:law_status, :string)
    field(:kvkk_accepted, :boolean)
  end

  @doc false
  @spec changeset(t | Ecto.Schema.t(), map) :: Ecto.Changeset.t()
  def changeset(schema, params) do
    schema
    |> cast(params, @attrs)
    |> Checker.validate_changeset()
  end
end
