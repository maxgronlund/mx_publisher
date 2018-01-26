defmodule MxPublisher.PublisherControllerTest do
  use MxPublisher.ConnCase

  alias MxPublisher.Publisher
  @valid_attrs %{cae_code: "some cae_code", description: "some description", email: "some email", ipi_code: "some ipi_code", legal_name: "some legal_name", phone_number: "some phone_number", secret_token: "some secret_token"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, publisher_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing publishers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, publisher_path(conn, :new)
    assert html_response(conn, 200) =~ "New publisher"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, publisher_path(conn, :create), publisher: @valid_attrs
    publisher = Repo.get_by!(Publisher, @valid_attrs)
    assert redirected_to(conn) == publisher_path(conn, :show, publisher.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, publisher_path(conn, :create), publisher: @invalid_attrs
    assert html_response(conn, 200) =~ "New publisher"
  end

  test "shows chosen resource", %{conn: conn} do
    publisher = Repo.insert! %Publisher{}
    conn = get conn, publisher_path(conn, :show, publisher)
    assert html_response(conn, 200) =~ "Show publisher"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, publisher_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    publisher = Repo.insert! %Publisher{}
    conn = get conn, publisher_path(conn, :edit, publisher)
    assert html_response(conn, 200) =~ "Edit publisher"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    publisher = Repo.insert! %Publisher{}
    conn = put conn, publisher_path(conn, :update, publisher), publisher: @valid_attrs
    assert redirected_to(conn) == publisher_path(conn, :show, publisher)
    assert Repo.get_by(Publisher, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    publisher = Repo.insert! %Publisher{}
    conn = put conn, publisher_path(conn, :update, publisher), publisher: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit publisher"
  end

  test "deletes chosen resource", %{conn: conn} do
    publisher = Repo.insert! %Publisher{}
    conn = delete conn, publisher_path(conn, :delete, publisher)
    assert redirected_to(conn) == publisher_path(conn, :index)
    refute Repo.get(Publisher, publisher.id)
  end
end
