defmodule Aquebra.Repo do
  use Ecto.Repo,
    otp_app: :aquebra,
    adapter: Ecto.Adapters.Postgres
end
