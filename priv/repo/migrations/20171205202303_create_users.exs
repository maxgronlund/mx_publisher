defmodule MxPublisher.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :username, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
