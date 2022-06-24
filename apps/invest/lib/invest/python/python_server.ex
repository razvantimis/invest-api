defmodule Invest.PythonServer do
  use GenServer
  alias Invest.PythonHelper

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, pid} =
      [:code.priv_dir(:invest), "python"]
      |> Path.join()
      |> to_charlist()
      |> PythonHelper.start_instance('python3')

    # register this process as the message handler
    PythonHelper.call_instance(pid, :elixir_handler, :register_handler, [self()])
    {:ok, pid}
  end

  def call_function(module, function, args) do
    GenServer.call(__MODULE__, {:call_function, module, function, args})
  end

  def handle_call({:call_function, module, function, args}, _from, pid) do
    result = PythonHelper.call_instance(pid, module, function, args)
    {:reply, result, pid}
  end

  def cast_function(args) do
    GenServer.cast(__MODULE__, {:cast_function, args})
  end

  def handle_cast({:cast_function, args}, pid) do
    PythonHelper.cast_instance(pid, args)
    {:noreply, pid}
  end

  def handle_info({:python, json}, pid) do
    IO.inspect("Received message from Python")
    resultData = Jason.decode!(json)
    IO.inspect(resultData)
    # for [date, price] <- results do
    #   %{date: "#{date}", price: "#{price}"}
    # end
    {:noreply, pid}
  end

end
