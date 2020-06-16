defmodule MinesweeperDuel.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :host, :string
      add :host_points, :integer
      add :guest, :string
      add :guest_points, :integer
      add :turn, :string

      timestamps()
    end

  end
end
