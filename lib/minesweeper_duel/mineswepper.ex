defmodule MinesweeperDuel.Mineswepper do
  @moduledoc """
  The Mineswepper context.
  """

  import Ecto.Query, warn: false
  alias MinesweeperDuel.Repo

  alias MinesweeperDuel.Mineswepper.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  alias MinesweeperDuel.Mineswepper.Cell

  @doc """
  Returns the list of cells.

  ## Examples

      iex> list_cells()
      [%Cell{}, ...]

  """
  def list_cells do
    Repo.all(Cell)
  end

  @doc """
  Gets a single cell.

  Raises `Ecto.NoResultsError` if the Cell does not exist.

  ## Examples

      iex> get_cell!(123)
      %Cell{}

      iex> get_cell!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cell!(id), do: Repo.get!(Cell, id)

  @doc """
  Creates a cell.

  ## Examples

      iex> create_cell(%{field: value})
      {:ok, %Cell{}}

      iex> create_cell(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cell(attrs \\ %{}) do
    %Cell{}
    |> Cell.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cell.

  ## Examples

      iex> update_cell(cell, %{field: new_value})
      {:ok, %Cell{}}

      iex> update_cell(cell, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cell(%Cell{} = cell, attrs) do
    cell
    |> Cell.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cell.

  ## Examples

      iex> delete_cell(cell)
      {:ok, %Cell{}}

      iex> delete_cell(cell)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cell(%Cell{} = cell) do
    Repo.delete(cell)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cell changes.

  ## Examples

      iex> change_cell(cell)
      %Ecto.Changeset{data: %Cell{}}

  """
  def change_cell(%Cell{} = cell, attrs \\ %{}) do
    Cell.changeset(cell, attrs)
  end
end
