defmodule ChessWeb.GameLive do
  use Phoenix.LiveView

  def render(assigns) do
    ChessWeb.GameView.render("game.html", assigns)
  end

  def mount(%{"id" => id}, _, socket) do
    {_, pid} = Chess.GameRegistry.lookup(id)
    state = Chess.Game.Server.get_state(pid)
    {:ok, assign(socket, game: state)}
  end
end
