defmodule {{ project_name }}.Application do

  @moduledoc false

  use Application

  def start(_type, _args) do

    :ok =
      :telemetry.attach(
        "logger-json-ecto",
        [:{{name}}, :repo, :query],
        &LoggerJSON.Ecto.telemetry_logging_handler/4,
        :debug
      )

    children = [
      # Start the Ecto repository
      {{ project_name }}.Repo,
      # Start the Telemetry supervisor
      {{ project_name }}Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: {{ project_name }}.PubSub},
      # Start the Endpoint (http/https)
      {{ project_name }}Web.Endpoint,

      {Registry, keys: :unique, name: ApiServicesRegistry},

      ApiServicesSupervisor,

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: {{ project_name }}.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
   {{project_name}}Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
