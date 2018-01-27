defmodule MxPublisherWeb.UserControllerTest do
  use MxPublisherWeb.ConnCase

  alias MxPublisher.Accounts
  alias MxPublisher.Repo
  alias MxPublisher.Conn

  @create_attrs %{username: "some name", password: "some password"}
  @update_attrs %{username: "some updated name", password: "some updated password"}
  @invalid_attrs %{username: nil, pasword: nil}


  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 302) =~ "<html><body>You are being <a href=\"/\">redirected</a>.</body></html>"
    end
  end

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do

      conn = post conn, user_path(conn, :create), user: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_path(conn, :show, id)

      conn = get conn, user_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "New User"
    end
  end

end
