defmodule MxPublisher.Repo.Migrations.CreateTrackers do
  use Ecto.Migration

  def change do
    create table(:trackers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :address, :string
      add :certificate, :text
      add :api_key, :string
      add :trust, :float, default: 0.5
      add :distance, :integer
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)
      add :last_seen, :utc_datetime
      add :last_requested, :utc_datetime

      timestamps()
    end

    create index(:trackers, [:user_id])
  end
end
