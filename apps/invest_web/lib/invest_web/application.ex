defmodule InvestWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      InvestWeb.Telemetry,
      # Start the Endpoint (http/https)
      InvestWeb.Endpoint
      # Start a worker by calling: InvestWeb.Worker.start_link(arg)
      # {InvestWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InvestWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InvestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
