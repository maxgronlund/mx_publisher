defmodule MxPublisher.MxNodes.Tracker do
  use Ecto.Schema
  import Ecto.Changeset
  alias MxPublisher.MxNodes.Tracker
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type

  schema "trackers" do
    field :name, :string
    field :url, :string
    field :public_rsa_key, :string
    field :trust, :float
    field :node_distance, :integer
    field :last_seen, :integer
    field :last_requested, :integer
    timestamps()
  end

  @doc false
  def changeset(%Tracker{} = tracker, attrs) do
    tracker
    |> cast(attrs, [:name, :url, :public_rsa_key])
    |> validate_required([:name, :url, :public_rsa_key])
  end
end
