defmodule MinesweeperDuel.Mineswepper.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias MinesweeperDuel.Mineswepper.Cell

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "games" do
    field :guest, :string
    field :guest_points, :integer, default: 0
    field :host, :string
    field :host_points, :integer, default: 0
    field :turn, :string, default: "guest"
    field :over, :boolean, default: false
    field :winner, :string
    has_many :cells, Cell

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:host, :host_points, :guest, :guest_points, :turn, :over, :winner])
    |> validate_required([:host, :host_points, :guest_points, :turn])
  end
end
