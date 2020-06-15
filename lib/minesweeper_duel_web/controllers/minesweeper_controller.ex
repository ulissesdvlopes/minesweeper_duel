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
    conn = put_session(conn, :user, host)
    result = Mineswepper.create_game(%{"host" => host})
    url = "/game-ms/#{result.id}"
    redirect(conn, to: url)
  end

  def live(conn, %{"id" => id}) do
    user = get_session(conn, :user)
    if user do
      game = Mineswepper.get_game_with_cells!(id)
      live_render(conn, MinesweeperDuelWeb.PageLive, session: %{"game" => game})
    else
      redirect(conn, to: "/game-ms/#{id}/enter")
    end
  end

  def enter(conn, _) do
    render(conn, "enter.html")
  end

  def create_session(conn, params) do
    %{"id" => id, "guest" => guest} = params
    IO.puts "***id***"
    IO.inspect id
    IO.puts "***guest***"
    IO.inspect guest
    conn = put_session(conn, :user, guest)
    # modify game to put guest user if there is not one already
    case Mineswepper.add_guest_to_game(id, guest) do
      {:ok, game} ->
        IO.puts "***changed game***"
        IO.inspect game
        url = "/game-ms/#{id}"
        redirect(conn, to: url)
      _ ->
        IO.puts "***could not join game***"
        conn
        |> put_flash(:error, "You could not join this game")
        |> redirect(to: "/game-ms/#{id}/enter")
    end
  end
end
