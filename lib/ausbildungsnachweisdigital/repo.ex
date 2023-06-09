defmodule Ausbildungsnachweisdigital.Repo do
  use Ecto.Repo,
    otp_app: :ausbildungsnachweisdigital,
    adapter: Ecto.Adapters.Postgres
end
