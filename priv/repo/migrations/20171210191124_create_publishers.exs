defmodule MxPublisher.Repo.Migrations.CreatePublishers do
  use Ecto.Migration

  def change do
    create table(:publishers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :legal_name, :string
      add :email, :string
      add :phone_number, :string
      add :ipi_code, :string
      add :cae_code, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:publishers, [:user_id])
  end
end
