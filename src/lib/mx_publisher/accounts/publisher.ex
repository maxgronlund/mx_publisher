defmodule MxPublisher.Accounts.Publisher do
  use Ecto.Schema
  import Ecto.Changeset
  alias MxPublisher.Accounts.Publisher
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type

  schema "publishers" do
    field :cae_code, :string
    field :description, :string
    field :email, :string
    field :ipi_code, :string
    field :legal_name, :string
    field :phone_number, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Publisher{} = publisher, attrs) do
    publisher
    |> cast(attrs, [:legal_name, :email, :phone_number, :ipi_code, :cae_code, :description])
    |> validate_required([:legal_name, :email, :phone_number, :ipi_code, :cae_code, :description])
  end
end
