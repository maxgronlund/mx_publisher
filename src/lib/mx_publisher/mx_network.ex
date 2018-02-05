defmodule MxPublisher.MxNetwork do
  @backends [MxPublisher.MxNetwork.SuperNode]

  defmodule Result do
    defstruct score: 0, text: nil, url: nil, backend: nil
  end

  def start_link(backend, query, query_ref, owner, limit) do
    backend.start_link(query, query_ref, owner, limit)
  end

  def compute(trackers, opts \\ []) do
    for tracker <- trackers do
      fetch_tracker(tracker.url, opts)
    end

  end

  def fetch_tracker(address, opts \\ []) do
    limit = opts[:limit] || 10
    backends = opts[:backends] || @backends
    backends
    |> Enum.map(&spawn_query(&1, address, limit))
    |> await_results(opts)
    |> print_result(opts)
  end

  defp spawn_query(backend, query, limit) do
    query_ref = make_ref()
    opts = [backend, query, query_ref, self(), limit]
    {:ok, pid} = Supervisor.start_child(MxPublisher.MxNetwork.Supervisor, opts)
    monitor_ref = Process.monitor(pid)
    {pid, monitor_ref, query_ref}
  end

  defp await_results(children, _opts) do
    await_result(children, [], :infinity)
  end

  defp await_result([head|tail], acc, timeout) do
    {pid, monitor_ref, query_ref} = head

    receive do
      {:results, ^query_ref, results} ->
        Process.demonitor(monitor_ref, [:flush])
        await_result(tail, results ++ acc, timeout)
      {:DOWN, ^monitor_ref, :process, ^pid, _reason} ->
        await_result(tail, acc, timeout)
    end
  end

  defp await_result([], acc, _) do
    acc
  end

  defp print_result( result, _opts) do
    #{score, text, url, backend} = result
    Apex.ap(result)

  end
end