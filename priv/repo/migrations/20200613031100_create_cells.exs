defmodule MinesweeperDuel.Repo.Migrations.CreateCells do
  use Ecto.Migration

  def change do
    create table(:cells) do
      add :row, :integer
      add :col, :integer
      add :revealed, :boolean, default: false, null: false
      add :has_mine, :boolean, default: false, null: false
      add :mines_around, :integer
      add :game_id, references(:games, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:cells, [:game_id])
  end
end
