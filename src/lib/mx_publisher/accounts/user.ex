defmodule MxPublisher.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MxPublisher.Accounts.User
  @primary_key {:id, :binary_id, autogenerate: true}


  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_length(:password, min: 6, max: 100)
    |> validate_email
    |> put_pass_hash()
    |> unique_constraint(:email)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  defp validate_email(changeset) do
    changeset
    |> downcase_email
    |> validate_format(:email, ~r/\A([^@\s]+)@((?:(?!-)[-a-z0-9]+(?<!-)\.)+[a-z]{2,})\z/)
  end

  defp downcase_email(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{email: email}} ->
        email = String.downcase(email)
        Ecto.Changeset.put_change(changeset, :email, email)
      _ ->
        changeset
    end
  end
end
