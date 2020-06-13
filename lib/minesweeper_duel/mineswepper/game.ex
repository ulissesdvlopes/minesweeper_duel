defmodule MinesweeperDuel.Mineswepper.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :guest, :string
    field :guest_points, :integer
    field :host, :string
    field :host_ponts, :integer
    field :turn, :string

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:host, :host_ponts, :guest, :guest_points, :turn])
    |> validate_required([:host, :host_ponts, :guest, :guest_points, :turn])
  end
end
