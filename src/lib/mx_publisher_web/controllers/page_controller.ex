defmodule MxPublisherWeb.PageController do
  use MxPublisherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", title: title(), public_key: public_key())
  end

  defp title, do: Application.get_env(:mx_publisher, :mx_network)[:title]

  defp public_key do
   {:ok, key} = File.read("config/test_rsa_public_key.pem")
   key
 end
end
