defmodule Ticky.Repo do
  use Ecto.Repo,
    otp_app: :ticky,
    adapter: Ecto.Adapters.Postgres
end
