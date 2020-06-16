defmodule MinesweeperDuelWeb.PageLive do
  use MinesweeperDuelWeb, :live_view

  alias MinesweeperDuel.Mineswepper

  @impl true
  def mount(_params, %{"game" => game, "user" => user}, socket) do
    role = get_user_role(user, game)
    {:ok, assign(socket, game: game, user: role)}
  end

  def get_user_role(user_name, game) do
    %{host: host, guest: guest} = game
    case user_name do
      ^host -> "host"
      ^guest -> "guest"
      _ -> nil
    end
  end

  def render_cell(%{revealed: revealed}) when revealed == false do
    ""
  end

  def render_cell(%{has_mine: has_mine}) when has_mine == true do
    "💣"
  end

  def render_cell(%{mines_around: mines_around}) when mines_around != 0 do
    "#{mines_around}"
  end

  def render_cell(_) do
    ""
  end

  # @impl true
  # def handle_event("open_cell", %{"revealed" => "true"}, socket) do
  #   IO.puts("*****open_cell*****")
  #   IO.puts("revealed false")
  #   {:noreply, socket}
  # end

  @impl true
  def handle_event("open_cell", params, socket) do
    game_id = socket.assigns.game.id
    user = params["user"]
    row = String.to_integer(params["row"])
    col = String.to_integer(params["col"])

    _result = Mineswepper.reveal_cell(game_id, user, row, col)
    # IO.puts("*result*")
    # IO.inspect(result)
    # IO.puts("*result*")
    {:noreply, socket}
  end

end
