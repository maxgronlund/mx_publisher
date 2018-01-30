defmodule MxPublisherWeb.TrackerController do
  use MxPublisherWeb, :controller

  alias MxPublisher.MxNodes
  alias MxPublisher.MxNodes.Tracker

  # plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    connect_to_network()
    trackers = MxNodes.list_trackers()
    render(conn, "index.html", trackers: trackers)
  end

  def new(conn, _params) do
    changeset = MxNodes.change_tracker(%Tracker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tracker" => tracker_params}) do
    case MxNodes.create_tracker(tracker_params) do
      {:ok, tracker} ->
        conn
        |> put_flash(:info, "Tracker created successfully.")
        |> redirect(to: tracker_path(conn, :show, tracker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tracker = MxNodes.get_tracker!(id)
    render(conn, "show.html", tracker: tracker)
  end

  def edit(conn, %{"id" => id}) do
    tracker = MxNodes.get_tracker!(id)
    changeset = MxNodes.change_tracker(tracker)
    render(conn, "edit.html", tracker: tracker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tracker" => tracker_params}) do
    tracker = MxNodes.get_tracker!(id)

    case MxNodes.update_tracker(tracker, tracker_params) do
      {:ok, tracker} ->
        conn
        |> put_flash(:info, "Tracker updated successfully.")
        |> redirect(to: tracker_path(conn, :show, tracker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tracker: tracker, changeset: changeset)
    end
  end



  defp connect_to_network do
    MxPublisher.MxNetwork.compute("http://localhost:4000/api/mx_trackers", %{backend: "MxPublisher.MxNetwork.SuperNode"})
  end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user!(id)
  #   {:ok, _user} = Accounts.delete_user(user)
#
  #   conn
  #   |> put_flash(:info, "User deleted successfully.")
  #   |> redirect(to: user_path(conn, :index))
  # end
#
  # defp authenticate(conn, _opts) do
  #   if conn.assigns.current_user do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You must be logged in to access that page")
  #     |> redirect(to: page_path(conn, :index))
  #     |> halt()
  #   end
  # end
end
