defmodule MinesweeperDuel.Repo do
  use Ecto.Repo,
    otp_app: :minesweeper_duel,
    adapter: Ecto.Adapters.Postgres
end
