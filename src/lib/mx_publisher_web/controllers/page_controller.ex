defmodule MxPublisherWeb.PageController do
  use MxPublisherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", title: title())
  end

  defp title, do: Application.get_env(:mx_publisher, :mx_network)[:title]
end
