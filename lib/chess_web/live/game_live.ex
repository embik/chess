defmodule ChessWeb.GameLive do
  alias ChessWeb.Router.Helpers, as: Routes

  use Phoenix.LiveView

  def render(assigns) do
    ChessWeb.GameView.render("game.html", assigns)
  end

  def mount(%{"id" => id}, _, socket) do
    case Chess.GameRegistry.lookup(id) do
      {:ok, pid} ->
        state = Chess.Game.Server.get_state(pid)
        {:ok, assign(socket, pid: pid, game: state)}
      :error ->
        {:ok,
          socket
          |> redirect(to: Routes.page_path(socket, :index))
        }
    end
  end

  def handle_event("select_piece", %{"x" => x, "y" => y}, %{assigns: assigns} = socket) do
    {x, _} = Integer.parse(x)
    {y, _} = Integer.parse(y)
    state = Chess.Game.Server.select_field(assigns.pid, :player1, x, y)

    {:noreply, assign(socket, game: state)}
  end
end
