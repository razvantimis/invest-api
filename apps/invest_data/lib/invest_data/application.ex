defmodule InvestData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Supervisor.Spec

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Invest.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InvestData.PubSub},
      worker(Mongo, [InvestData.Repo.config()]),
      InvestData.Scheduler
      # worker(Mongo, [[name: :mongo, database: database_url, pool_size: pool_size]])

      # Start a worker by calling: InvestData.Worker.start_link(arg)
      # {Invest.Worker, arg}
      # :poolboy.child_spec(:worker, python_poolboy_config())
    ]

    result = Supervisor.start_link(children, strategy: :one_for_one, name: Invest.Supervisor)

    add_db_index()
    result
  end

  defp add_db_index() do
    indexes = [
      [key: [symbol: 1, date: 1], name: "index_symbol_date", unique: true]
    ]

    Mongo.create_indexes(
      :mongo,
      InvestData.Entities.StockPrice.__collection__(:collection),
      indexes
    )

    indexes = [
      [key: [fromCurrency: 1, toCurrency: 1, date: 1], name: "index_from_to_date", unique: true],
      [key: [date: 1], name: "index_date"]
    ]

    Mongo.create_indexes(
      :mongo,
      InvestData.Entities.CurrencyExchangeRate.__collection__(:collection),
      indexes
    )
  end
end
