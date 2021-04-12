defmodule FutureMadeConcerts.Repo do
  use Ecto.Repo,
    otp_app: :FutureMadeConcerts,
    adapter: Ecto.Adapters.Postgres
end
