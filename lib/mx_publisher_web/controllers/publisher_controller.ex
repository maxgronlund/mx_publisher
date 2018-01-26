defmodule MxPublisherWeb.PublisherController do
  use MxPublisherWeb, :controller

  alias MxPublisher.Accounts
  alias MxPublisher.Accounts.Publisher

  def index(conn, _params) do
    publishers = Accounts.list_publishers()
    render(conn, "index.html", publishers: publishers)
  end

  def new(conn, _params) do
    changeset = Accounts.change_publisher(%Publisher{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"publisher" => publisher_params}) do
    case Accounts.create_publisher(publisher_params) do
      {:ok, publisher} ->
        conn
        |> put_flash(:info, "Publisher created successfully.")
        |> redirect(to: publisher_path(conn, :show, publisher))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    publisher = Accounts.get_publisher!(id)
    render(conn, "show.html", publisher: publisher)
  end

  def edit(conn, %{"id" => id}) do
    publisher = Accounts.get_publisher!(id)
    changeset = Accounts.change_publisher(publisher)
    render(conn, "edit.html", publisher: publisher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "publisher" => publisher_params}) do
    publisher = Accounts.get_publisher!(id)

    case Accounts.update_publisher(publisher, publisher_params) do
      {:ok, publisher} ->
        conn
        |> put_flash(:info, "Publisher updated successfully.")
        |> redirect(to: publisher_path(conn, :show, publisher))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", publisher: publisher, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    publisher = Accounts.get_publisher!(id)
    {:ok, _publisher} = Accounts.delete_publisher(publisher)

    conn
    |> put_flash(:info, "Publisher deleted successfully.")
    |> redirect(to: publisher_path(conn, :index))
  end
end
