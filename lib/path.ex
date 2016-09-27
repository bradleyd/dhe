defmodule Endpoint.Path do
  use GenServer
  require Logger

  @template "index.html.eex"

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(args) do
    {:ok, args}
  end

  def run(args) do
    # do something with params
    query_params = args
    EEx.eval_file(@template, [whoami: Node.self])
  end
end
