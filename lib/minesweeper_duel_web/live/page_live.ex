defmodule MinesweeperDuelWeb.PageLive do
  use MinesweeperDuelWeb, :live_view

  @impl true
  def mount(_params, %{"game" => game}, socket) do
    {:ok, assign(socket, game: game)}
  end

  # def render_cell(%{revealed: revealed}) when revealed == false do
  #   ""
  # end

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
    IO.puts("*****open_cell-row*****")
    IO.inspect(params["row"])
    IO.puts("*****open_cell-col*****")
    IO.inspect(params["col"])
    # row_position = String.to_integer(params["row"])
    # cell_position = String.to_integer(params["cell"])
    # game_id = params["game"]

    # result = Minesweeper.reveal_cell(game_id, row_position, cell_position)
    # IO.puts("*result*")
    # IO.inspect(result)
    # IO.puts("*result*")
    {:noreply, socket}
  end

end
