defmodule MxPublisher.MxNetwork.SuperNode do
  import Poison
  alias MxPublisher.MxNetwork.Result

  def start_link(query, query_ref, owner, limit) do
    Task.start_link(__MODULE__, :fetch, [query, query_ref, owner, limit])
  end

  def fetch(query_str, query_ref, owner, _limit) do
    query_str
    |> fetch_json()
    # |> xpath(~x"/queryresult/pod[contains(@title, 'Result') or
    #                              contains(@title, 'Definitions')]
    #                         /subpod/plaintext/text()")
    |> send_results(query_ref, owner)
  end

  defp send_results(nil, query_ref, owner) do
    send(owner, {:results, query_ref, []})
  end

  defp send_results(answer, query_ref, owner) do
    results = [%Result{backend: "super_node", score: 95, text: to_string(answer)}]
    send(owner, {:results, query_ref, results})
  end

  defp fetch_json(query_str) do
    {:ok, {_, _, body}} = :httpc.request(
      String.to_char_list("http://localhost:4000/api/mx_trackers")
    )
      # String.to_char_list("http://api.wolframalpha.com/v2/query" <>
      #   "?appid=#{app_id()}" <>
      #   "&input=#{URI.encode(query_str)}&format=plaintext"))
    fo = Poison.decode!(body)
    Apex.ap(fo)
    body
  end

  defp app_id, do: Application.get_env(:mx_publisher, :wolfram)[:app_id]
end