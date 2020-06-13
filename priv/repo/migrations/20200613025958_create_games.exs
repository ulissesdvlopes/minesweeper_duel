defmodule MinesweeperDuel.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :host, :string
      add :host_ponts, :integer
      add :guest, :string
      add :guest_points, :integer
      add :turn, :string

      timestamps()
    end

  end
end
