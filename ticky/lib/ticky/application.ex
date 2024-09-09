defmodule Ticky.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TickyWeb.Telemetry,
      Ticky.Repo,
      {DNSCluster, query: Application.get_env(:ticky, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ticky.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ticky.Finch},
      # Start a worker by calling: Ticky.Worker.start_link(arg)
      # {Ticky.Worker, arg},
      # Start to serve requests, typically the last entry
      TickyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ticky.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TickyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
