defmodule MxPublisher.Repo.Migrations.CreateTrackers do
  use Ecto.Migration

  def change do
    create table(:trackers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :address, :string
      add :certificate, :text
      add :api_key, :string
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:trackers, [:user_id])
  end
end
