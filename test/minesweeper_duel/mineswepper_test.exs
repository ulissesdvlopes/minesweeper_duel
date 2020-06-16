defmodule MinesweeperDuel.MineswepperTest do
  use MinesweeperDuel.DataCase

  alias MinesweeperDuel.Mineswepper

  describe "games" do
    alias MinesweeperDuel.Mineswepper.Game

    @valid_attrs %{guest: "some guest", guest_points: 42, host: "some host", host_points: 42, turn: "some turn"}
    @update_attrs %{guest: "some updated guest", guest_points: 43, host: "some updated host", host_points: 43, turn: "some updated turn"}
    @invalid_attrs %{guest: nil, guest_points: nil, host: nil, host_points: nil, turn: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mineswepper.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Mineswepper.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Mineswepper.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Mineswepper.create_game(@valid_attrs)
      assert game.guest == "some guest"
      assert game.guest_points == 42
      assert game.host == "some host"
      assert game.host_points == 42
      assert game.turn == "some turn"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mineswepper.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Mineswepper.update_game(game, @update_attrs)
      assert game.guest == "some updated guest"
      assert game.guest_points == 43
      assert game.host == "some updated host"
      assert game.host_points == 43
      assert game.turn == "some updated turn"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Mineswepper.update_game(game, @invalid_attrs)
      assert game == Mineswepper.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Mineswepper.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Mineswepper.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Mineswepper.change_game(game)
    end
  end

  describe "cells" do
    alias MinesweeperDuel.Mineswepper.Cell

    @valid_attrs %{col: 42, has_mine: true, mines_around: 42, revealed: true, row: 42}
    @update_attrs %{col: 43, has_mine: false, mines_around: 43, revealed: false, row: 43}
    @invalid_attrs %{col: nil, has_mine: nil, mines_around: nil, revealed: nil, row: nil}

    def cell_fixture(attrs \\ %{}) do
      {:ok, cell} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mineswepper.create_cell()

      cell
    end

    test "list_cells/0 returns all cells" do
      cell = cell_fixture()
      assert Mineswepper.list_cells() == [cell]
    end

    test "get_cell!/1 returns the cell with given id" do
      cell = cell_fixture()
      assert Mineswepper.get_cell!(cell.id) == cell
    end

    test "create_cell/1 with valid data creates a cell" do
      assert {:ok, %Cell{} = cell} = Mineswepper.create_cell(@valid_attrs)
      assert cell.col == 42
      assert cell.has_mine == true
      assert cell.mines_around == 42
      assert cell.revealed == true
      assert cell.row == 42
    end

    test "create_cell/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mineswepper.create_cell(@invalid_attrs)
    end

    test "update_cell/2 with valid data updates the cell" do
      cell = cell_fixture()
      assert {:ok, %Cell{} = cell} = Mineswepper.update_cell(cell, @update_attrs)
      assert cell.col == 43
      assert cell.has_mine == false
      assert cell.mines_around == 43
      assert cell.revealed == false
      assert cell.row == 43
    end

    test "update_cell/2 with invalid data returns error changeset" do
      cell = cell_fixture()
      assert {:error, %Ecto.Changeset{}} = Mineswepper.update_cell(cell, @invalid_attrs)
      assert cell == Mineswepper.get_cell!(cell.id)
    end

    test "delete_cell/1 deletes the cell" do
      cell = cell_fixture()
      assert {:ok, %Cell{}} = Mineswepper.delete_cell(cell)
      assert_raise Ecto.NoResultsError, fn -> Mineswepper.get_cell!(cell.id) end
    end

    test "change_cell/1 returns a cell changeset" do
      cell = cell_fixture()
      assert %Ecto.Changeset{} = Mineswepper.change_cell(cell)
    end
  end
end
