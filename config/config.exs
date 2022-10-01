import Config

config :{{name}},
  ecto_repos: [{{project_name}}.Repo]

# Configures the endpoint
config :{{name}}, {{project_name}}Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "djMsbowxRw7ADSe46U8FeCaz2LdBob+oWEYp4U8bXYNPIMH7Sc1zXilAplds5CD/",
  render_errors: [view: {{project_name}}Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: {{project_name}}.PubSub,
  live_view: [signing_salt: "8Dr7ZgsF"]


# Configures Elixir's Logger
config :logger, :console,
       format: "$time $metadata [$level] $message\n",
       metadata: :all#,
#       handle_otp_reports: true,
#       handle_sasl_reports: true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
