defmodule NumberExtension.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NumberExtensionWeb.Telemetry,
      NumberExtension.Repo,
      {DNSCluster, query: Application.get_env(:number_extension, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NumberExtension.PubSub},
      # Start a worker by calling: NumberExtension.Worker.start_link(arg)
      # {NumberExtension.Worker, arg},
      # Start to serve requests, typically the last entry
      NumberExtensionWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NumberExtension.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NumberExtensionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
