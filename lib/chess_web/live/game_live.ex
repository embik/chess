defmodule ChessWeb.GameLive do
  use Phoenix.LiveView

  def render(assigns) do
    ChessWeb.GameView.render("game.html", assigns)
  end

  def mount(%{"id" => id}, _, socket) do
    {_, pid} = Chess.GameRegistry.lookup(id)
    state = Chess.Game.Server.get_state(pid)
    {:ok, assign(socket, pid: pid, game: state)}
  end

  def handle_event("select_piece", %{"x" => x, "y" => y}, %{assigns: assigns} = socket) do
    {x, _} = Integer.parse(x)
    {y, _} = Integer.parse(y)
    state = Chess.Game.Server.select_field(assigns.pid, :player1, x, y)

    {:noreply, assign(socket, game: state)}
  end
end
