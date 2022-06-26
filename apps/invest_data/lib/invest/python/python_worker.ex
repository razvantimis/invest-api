defmodule InvestData.PythonWorker do
  use GenServer
  alias InvestData.PythonHelper
  require Logger
  @timeout 10_000

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def call(function, json_input) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid ->
          GenServer.call(pid, {function, [json_input]})
        end,
        @timeout
      )
    end)
    |> Task.await(@timeout)
  end

  #############
  # Callbacks #
  #############

  @impl true
  def init(_) do
    path =
      [:code.priv_dir(:invest_data), "python"]
      |> Path.join()
      |> to_charlist()

    with {:ok, pid} <- PythonHelper.start_instance(path, 'python3') do
      Logger.info("[#{__MODULE__}] Started python worker")

      {:ok, pid}
    end
  end

  @impl true
  def handle_call({function, args}, _from, pid) do
    Logger.info("[#{__MODULE__}] call #{function}()")
    result = PythonHelper.call_instance(pid, function, args)
    {:reply, {:ok, result}, pid}
  end
end
