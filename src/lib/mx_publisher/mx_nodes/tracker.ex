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

    timestamps()
  end

  @doc false
  def changeset(%Tracker{} = tracker, attrs) do
    tracker
    |> cast(attrs, [:address, :certificate, :api_key])
    |> validate_required([:address, :certificate, :api_key])
  end
end
