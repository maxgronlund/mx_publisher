defmodule MxPublisher.Repo.Migrations.CreateTrackers do
  use Ecto.Migration

  def change do
    create table(:trackers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :url, :string
      add :public_rsa_key, :text
      add :trust, :float, default: 0.5
      add :node_distance, :integer
      add :last_seen, :integer
      add :last_requested, :integer

      timestamps()
    end
  end
end
