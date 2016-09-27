defmodule Endpoint.Path do
  use GenServer

  @template "index.html.eex"

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(args) do
    {:ok, args}
  end

  def run(args) do
    deserialized = deserialize(args)
    result       = EEx.eval_file(@template, [whoami: Node.self])
    serialize(result)
  end


  defp serialize(terms) do
    :erlang.term_to_binary(terms)
  end
  defp deserialize(bin) do
    :erlang.binary_to_term(bin)
  end
end
