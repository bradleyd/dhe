defmodule Endpoint.Discovery do
  use GenServer

  @timer 60_000

  @paths  Application.get_env(:endpoint, :paths)
  @router Application.get_env(:endpoint, :router)

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(args) do
    #:erlang.send_after(@timer, __MODULE__, :register)
    results = :rpc.call(@router, Router.Registry, :add_endpoint, [{node, @paths}])
    {:ok, results}
  end

  def handle_call(_message, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(_message, state) do
    {:noreply, state}
  end

  def handle_info(_message, state) do
    {:noreply, state}
  end

end
