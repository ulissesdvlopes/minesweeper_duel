defmodule MinesweeperDuelWeb.MinesweeperController do
  use MinesweeperDuelWeb, :controller

  alias MinesweeperDuel.Mineswepper
  import Phoenix.LiveView.Controller

  def index(conn, _) do
    render(conn, "index.html")
  end

  def create(conn, %{"host" => host}) do
    IO.puts "***host***"
    IO.inspect host
    result = Mineswepper.create_game(%{"host" => host})
    url = "/game-ms/#{result.id}"
    redirect(conn, to: url)
  end

  def live(conn, %{"id" => id}) do
    game = Mineswepper.get_game!(id)
    live_render(conn, MinesweeperDuelWeb.PageLive, session: %{"game" => game})
  end
end
