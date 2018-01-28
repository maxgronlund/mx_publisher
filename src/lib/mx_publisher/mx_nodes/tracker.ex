defmodule MxPublisher.MxNodes.Tracker do
  use Ecto.Schema
  import Ecto.Changeset
  alias MxPublisher.MxNodes.Tracker
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type

  schema "trackers" do
    field :address, :string
    field :api_key, :string
    field :certificate, :string
    field :user_id, :id
    field :trust, :float
    field :last_seen, :naive_datetime
    field :last_requested, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(%Tracker{} = tracker, attrs) do
    tracker
    |> cast(attrs, [:address, :certificate, :api_key, :trust, :last_seen, :last_requested])
    |> validate_required([:address, :certificate, :api_key, :trust, :last_seen, :last_requested])
  end
end
