defmodule MinesweeperDuel.Mineswepper do
  @moduledoc """
  The Mineswepper context.
  """

  import Ecto.Query, warn: false
  alias MinesweeperDuel.Repo

  alias MinesweeperDuel.Mineswepper.Game
  alias MinesweeperDuel.Mineswepper.Cell

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
  def get_game!(id) do 
    query_cells = from c in Cell, order_by: c.row, order_by: c.col

    Repo.get!(Game, id)
    |> Repo.preload(cells: query_cells)
  end

  defp sort_mines(map, turn \\ 0) do
    case turn do
      51 -> map
      _ -> add_mine(map, turn)
    end
  end

  defp add_mine(map, turn) do
    row = Enum.random(0..15)
    cell = Enum.random(0..15)

    if(!Map.has_key?(map, {row, cell})) do
      sort_mines(Map.put(map, {row, cell}, true), turn + 1)
    else
      sort_mines(map, turn)
    end
  end

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    {:ok, game} = 
      %Game{}
      |> Game.changeset(attrs)
      |> Repo.insert()
    
    mine_positions = sort_mines(%{})

    create_cell(game.id, mine_positions)
    game
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

  defp get_adjacents(row, col) do
    for x <- Range.new(row - 1, row + 1),
      y <- Range.new(col - 1, col + 1),
      cell_exists?(x, y) && !(x == row && y == col),
      do: {x, y}
  end

  defp cell_exists?(row,col) do
    (row >= 0 && col >= 0 && row <= 15 && col <= 15)
  end

  defp get_mines_around(mines_map, row, col) do
    Enum.reduce(get_adjacents(row, col), 0, fn {row, col}, acc ->
      if(Map.has_key?(mines_map, {row, col})) do
        acc + 1
      else
        acc
      end
    end)
  end

  @doc """
  Creates a cell.

  ## Examples

      iex> create_cell(game_id)
      {:ok, %Cell{}}

      iex> create_cell(null)
      {:error, %Ecto.Changeset{}}

  """
  defp create_cell(game_id, mine_positions, row \\ 0, col \\ 0) do
    {:ok, cell} =
      %Cell{}
      |> Cell.changeset(%{
        game_id: game_id,
        has_mine: Map.has_key?(mine_positions, {row, col}),
        row: row, 
        col: col,
        mines_around: get_mines_around(mine_positions, row, col)
      })
      |> Repo.insert()

    if(row < 15) do
      create_cell(game_id, mine_positions, row + 1, col)
    end
    if(row == 15 && col < 15) do
      create_cell(game_id, mine_positions, 0, col + 1)
    end
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
