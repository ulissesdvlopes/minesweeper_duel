defmodule MinesweeperDuelWeb.PageLive do
  use MinesweeperDuelWeb, :live_view

  alias MinesweeperDuel.Mineswepper
  alias MinesweeperDuelWeb.Endpoint

  @impl true
  def mount(_params, %{"game" => game, "user" => user}, socket) do
    IO.puts "******mount******"
    Endpoint.subscribe("update")
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

  def render_cell(%{has_mine: has_mine, revealed_by: revealed_by}) when has_mine == true do
    case revealed_by do
      "host" -> content_tag :span, "🏳️", class: "flag"
      "guest" -> content_tag :span, "🚩"
      _ -> content_tag :span, "💣"
    end
  end

  def render_cell(%{mines_around: mines_around}) when mines_around != 0 do
    "#{mines_around}"
  end

  def render_cell(_) do
    content_tag :span, "", class: "empty-cell"
  end

  @impl true
  def handle_event("open_cell", %{"revealed" => "true"}, socket) do
    IO.puts("*****open_cell*****")
    IO.puts("revealed false")
    {:noreply, socket}
  end

  @impl true
  def handle_event("open_cell", params, socket) do
    # game_id = socket.assigns.game.id
    # user = params["user"]
    # row = String.to_integer(params["row"])
    # col = String.to_integer(params["col"])
    %{id: game_id, turn: turn} = socket.assigns.game
    %{"user" => user, "row" => row_string, "col" => col_string} = params
    cond do
      turn == user ->
        row = String.to_integer(row_string)
        col = String.to_integer(col_string)
        result = Mineswepper.open(game_id, user, row, col)
        Endpoint.broadcast_from(self(), "update", "reveal", result)
        {:noreply, assign(socket, game: result)}
      true -> {:noreply, socket}
    end
  end

  @impl true
  def handle_info(%{topic: "update", payload: result}, socket) do
    IO.puts "Received message..."
    IO.inspect result
    {:noreply, assign(socket, game: result)}
  end

end
