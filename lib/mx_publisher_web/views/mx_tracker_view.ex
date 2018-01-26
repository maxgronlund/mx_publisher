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
      address: mx_tracker.address,
      certificate: mx_tracker.certificate,
      api_key: mx_tracker.api_key}
  end
end
