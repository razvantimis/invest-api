defmodule InvestData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Invest.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InvestData.PubSub},
      # Start a worker by calling: InvestData.Worker.start_link(arg)
      # {Invest.Worker, arg}
      InvestData.PythonServer,
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Invest.Supervisor)
  end
end
