defmodule FutureMadeConcerts.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    config = Vapor.load!(FutureMadeConcerts.Config)

    FutureMadeConcerts.Spotify.Auth.configure!(config.spotify)

    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: FutureMadeConcerts.PubSub},
      # Start the Endpoint (http/https)
      FutureMadeConcertsWeb.Endpoint,
      # Start a worker by calling: FutureMadeConcerts.Worker.start_link(arg)
      {Finch, name: FutureMadeConcerts.Finch},
      FutureMadeConcerts.Spotify.Supervisor,
      # Start the Telemetry supervisor
      FutureMadeConcertsWeb.Telemetry,
      {TelemetryMetricsAppsignal, [metrics: FutureMadeConcertsWeb.Telemetry.metrics()]},
      {FutureMadeConcertsWeb.Telemetry.Storage, FutureMadeConcertsWeb.Telemetry.metrics()},
      {FutureMadeConcerts.Repo, []}

      # {FutureMadeConcerts.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FutureMadeConcerts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FutureMadeConcertsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
