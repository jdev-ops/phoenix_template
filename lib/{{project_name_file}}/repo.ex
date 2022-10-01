defmodule {{ project_name }}.Repo do
  use Ecto.Repo,
    otp_app: :{{ name }},
    adapter: Ecto.Adapters.Postgres,
    log: false
end
