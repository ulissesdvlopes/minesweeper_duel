defmodule MinesweeperDuel.Mineswepper.Cell do
  use Ecto.Schema
  import Ecto.Changeset

  alias MinesweeperDuel.Mineswepper.Game

  @foreign_key_type :binary_id
  schema "cells" do
    field :col, :integer
    field :has_mine, :boolean, default: false
    field :mines_around, :integer
    field :revealed, :boolean, default: false
    field :revealed_by, :string
    field :row, :integer
    # field :game_id, :id
    belongs_to :game, Game

    timestamps()
  end

  @doc false
  def changeset(cell, attrs) do
    cell
    |> cast(attrs, [:row, :col, :revealed, :has_mine, :mines_around, :game_id, :revealed_by])
    |> validate_required([:row, :col, :game_id])
  end
end
