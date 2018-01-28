defmodule MxPublisher.MxNetwork.SuperNode do
  import Poison
  alias MxPublisher.MxNetwork.Result

  def start_link(tracker_url, query_ref, owner, limit) do
    Task.start_link(__MODULE__, :fetch, [tracker_url, query_ref, owner, limit])
  end

  def fetch(tracker_url, query_ref, owner, _limit) do
    fetch_json(tracker_url)
    |> send_results(query_ref, owner)
  end

  defp send_results(nil, query_ref, owner) do
    send(owner, {:results, query_ref, []})
  end

  defp send_results(answer, query_ref, owner) do
    results = [%Result{backend: "super_node", score: 95, text: Poison.decode!(answer)}]
    send(owner, {:results, query_ref, results})
  end

  defp fetch_json(tracker_url) do
    {:ok, {_, _, body}} = :httpc.request(
      String.to_char_list(tracker_url)
    )
    body
  end

  defp app_id, do: Application.get_env(:mx_publisher, :wolfram)[:app_id]
end