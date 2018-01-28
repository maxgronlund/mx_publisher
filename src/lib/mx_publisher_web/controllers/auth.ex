defmodule MxPublisherWeb.Auth do
  import Plug.Conn

  alias MxPublisher.Accounts
  alias MxPublisher.Accounts.User

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    Apex.ap(session_id)
    user_id = get_session(conn, session_id)
    user    = user_id && Accounts.get_user!(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(session_id, user.id)
    |> configure_session(renew: true)
  end

  defp session_id, do: Application.get_env(:mx_publisher, :mx_network)[:session_id]
end