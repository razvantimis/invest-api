defmodule Invest.Application do
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
      {Phoenix.PubSub, name: Invest.PubSub},
      # Start a worker by calling: Invest.Worker.start_link(arg)
      # {Invest.Worker, arg}
      Invest.PythonServer,
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Invest.Supervisor)
  end
end
