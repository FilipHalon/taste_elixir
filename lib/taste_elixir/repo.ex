defmodule TasteElixir.Repo do
  use Ecto.Repo,
    otp_app: :taste_elixir,
    adapter: Ecto.Adapters.Postgres
end
