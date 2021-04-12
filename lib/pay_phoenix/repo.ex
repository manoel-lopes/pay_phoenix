defmodule PayPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :pay_phoenix,
    adapter: Ecto.Adapters.Postgres
end
