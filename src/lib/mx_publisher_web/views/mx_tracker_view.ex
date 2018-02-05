defmodule MxPublisherWeb.MxTrackerView do
  use MxPublisherWeb, :view
  alias MxPublisherWeb.MxTrackerView

  def render("index.json", %{mx_trackers: mx_trackers}) do
    %{data: render_many(mx_trackers, MxTrackerView, "mx_tracker.json")}
  end

  def render("show.json", %{mx_tracker: mx_tracker}) do
    %{data: render_one(mx_tracker, MxTrackerView, "mx_tracker.json")}
  end

  def render("mx_tracker.json", %{mx_tracker: mx_tracker}) do
    %{id: mx_tracker.id,
      address: mx_tracker.url,
      trust: mx_tracker.trust,
      node_distance: mx_tracker.node_distance,
      last_seen: mx_tracker.last_seen,
      last_requested: mx_tracker.last_requested
    }
  end
end
