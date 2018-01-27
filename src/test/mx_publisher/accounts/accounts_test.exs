defmodule MxPublisher.AccountsTest do
  use MxPublisher.DataCase

  alias MxPublisher.Accounts

  describe "users" do
    alias MxPublisher.Accounts.User


    @valid_attrs %{username: "some name", password: "some password"}
    @update_attrs %{username: "some updated name", password: "some updated password"}
    @invalid_attrs %{username: nil, pasword: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      users =  Accounts.list_users()
      first_user = List.first(users)
      assert first_user.username == user.username
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).username == user.username
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.username == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.username == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.username == Accounts.get_user!(user.id).username
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "publishers" do
    alias MxPublisher.Accounts.Publisher

    @valid_attrs %{cae_code: "some cae_code", description: "some description", email: "some email", ipi_code: "some ipi_code", legal_name: "some legal_name", phone_number: "some phone_number"}
    @update_attrs %{cae_code: "some updated cae_code", description: "some updated description", email: "some updated email", ipi_code: "some updated ipi_code", legal_name: "some updated legal_name", phone_number: "some updated phone_number"}
    @invalid_attrs %{cae_code: nil, description: nil, email: nil, ipi_code: nil, legal_name: nil, phone_number: nil}

    def publisher_fixture(attrs \\ %{}) do
      {:ok, publisher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_publisher()

      publisher
    end

    test "list_publishers/0 returns all publishers" do
      publisher = publisher_fixture()
      assert Accounts.list_publishers() == [publisher]
    end

    test "get_publisher!/1 returns the publisher with given id" do
      publisher = publisher_fixture()
      assert Accounts.get_publisher!(publisher.id) == publisher
    end

    test "create_publisher/1 with valid data creates a publisher" do
      assert {:ok, %Publisher{} = publisher} = Accounts.create_publisher(@valid_attrs)
      assert publisher.cae_code == "some cae_code"
      assert publisher.description == "some description"
      assert publisher.email == "some email"
      assert publisher.ipi_code == "some ipi_code"
      assert publisher.legal_name == "some legal_name"
      assert publisher.phone_number == "some phone_number"
    end

    test "create_publisher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_publisher(@invalid_attrs)
    end

    test "update_publisher/2 with valid data updates the publisher" do
      publisher = publisher_fixture()
      assert {:ok, publisher} = Accounts.update_publisher(publisher, @update_attrs)
      assert %Publisher{} = publisher
      assert publisher.cae_code == "some updated cae_code"
      assert publisher.description == "some updated description"
      assert publisher.email == "some updated email"
      assert publisher.ipi_code == "some updated ipi_code"
      assert publisher.legal_name == "some updated legal_name"
      assert publisher.phone_number == "some updated phone_number"
    end

    test "update_publisher/2 with invalid data returns error changeset" do
      publisher = publisher_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_publisher(publisher, @invalid_attrs)
      assert publisher == Accounts.get_publisher!(publisher.id)
    end

    test "delete_publisher/1 deletes the publisher" do
      publisher = publisher_fixture()
      assert {:ok, %Publisher{}} = Accounts.delete_publisher(publisher)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_publisher!(publisher.id) end
    end

    test "change_publisher/1 returns a publisher changeset" do
      publisher = publisher_fixture()
      assert %Ecto.Changeset{} = Accounts.change_publisher(publisher)
    end
  end
end
