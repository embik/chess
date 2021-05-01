defmodule Chess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Telemetry.Metrics

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Chess.Repo,
      # Start the Telemetry supervisor
      ChessWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chess.PubSub},
      # Start the Prometheus exporter
      {TelemetryMetricsPrometheus, [metrics: metrics()]},
      # Start the Endpoint (http/https)
      ChessWeb.Endpoint,
      # Start the GameSupervisor
      Chess.GameSupervisor
      # Start a worker by calling: Chess.Worker.start_link(arg)
      # {Chess.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chess.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChessWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp metrics, do:
    [
      Metrics.sum("vm.memory.total")
    ]
end
