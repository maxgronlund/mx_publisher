defmodule MxPublisherWeb.PageController do
  use MxPublisherWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
