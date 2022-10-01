import Config

config :logger, level: :info


config :logger_json, :backend,
       metadata: :all,
         #   # Customization of https://github.com/Nebo15/logger_json/blob/master/lib/logger_json/formatters/google_cloud_logger.ex
       formatter: LoggerJSON.Formatters.BasicLogger

config :logger,
       backends: [LoggerJSON],
       handle_otp_reports: true,
       handle_sasl_reports: true

# Configure your database
config :{{name}},
       {{project_name}}.Repo,
       hostname: System.get_env("POSTGRES_DATABASE_HOST", "localhost"),
       username: System.get_env("POSTGRES_DATABASE_USER", "postgres"),
       password: System.get_env("POSTGRES_DATABASE_PASS", "postgres"),
       database: "$name$_prod",
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

secret_key_base =
  System.get_env("SECRET_KEY_BASE", "SECRET_KEY_BASE")

config :{{name}}, {{project_name}}Web.Endpoint,
       http: [
         port: String.to_integer(System.get_env("PORT") || "4000"),
         transport_options: [socket_opts: [:inet6]]
       ],
       secret_key_base: secret_key_base
