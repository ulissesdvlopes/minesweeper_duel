defmodule MinesweeperDuel.Mineswepper.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias MinesweeperDuel.Mineswepper.Cell

  schema "games" do
    field :guest, :string
    field :guest_points, :integer, default: 0
    field :host, :string
    field :host_ponts, :integer, default: 0
    field :turn, :string, default: "guest"
    has_many :cells, Cell

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:host, :host_ponts, :guest, :guest_points, :turn])
    |> validate_required([:host, :host_ponts, :guest_points, :turn])
  end
end
