defmodule MinesweeperDuelWeb.MinesweeperController do
  use MinesweeperDuelWeb, :controller

  alias MinesweeperDuel.Minesweeper
  import Phoenix.LiveView.Controller

  def index(conn, _) do
    render(conn, "index.html")
  end

  def create(conn, %{"host" => host}) do
    IO.puts "***host***"
    IO.inspect host
    # result = Minesweeper.create_game(%{"host" => host})
    # url = "/game/#{result.id}"
    # redirect(conn, to: url)
    redirect(conn, to: "/")
  end

  def live(conn, %{"id" => id}) do
    game = Minesweeper.get_game!(id)
    live_render(conn, MinesweeperDuelWeb.PageLive, session: %{"game" => game})
  end
end
