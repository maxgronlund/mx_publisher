defmodule MxPublisherWeb.MxTrackerController do
  use MxPublisherWeb, :controller

  alias MxPublisher.MxNodes
  alias MxPublisher.MxNodes.Tracker

  action_fallback MxPublisherWeb.FallbackController

  def index(conn, _params) do
    mx_trackers = MxNodes.list_trackers()
    render(conn, "index.json", mx_trackers: mx_trackers)
  end

  def create(conn, %{"tracker" => tracker_params}) do

    with {:ok, %Tracker{} = tracker} <- MxNodes.create_tracker(tracker_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tracker_path(conn, :show, tracker))
      |> render("show.json", tracker: tracker)
    end
  end

  def show(conn, %{"id" => id}) do
    mx_tracker = MxNodes.get_tracker!(id)
    render(conn, "show.json", mx_tracker: mx_tracker)
  end

  def update(conn, %{"id" => id, "tracker" => tracker_params}) do
    tracker = MxNodes.get_tracker!(id)

    with {:ok, %Tracker{} = tracker} <- MxNodes.update_tracker(tracker, tracker_params) do
      render(conn, "show.json", tracker: tracker)
    end
  end

  def delete(conn, %{"id" => id}) do
    tracker = MxNodes.get_tracker!(id)
    with {:ok, %Tracker{}} <- MxNodes.delete_tracker(tracker) do
      send_resp(conn, :no_content, "")
    end
  end
end
