defmodule NumberExtension.Repo do
  use Ecto.Repo,
    otp_app: :number_extension,
    adapter: Ecto.Adapters.SQLite3
end
