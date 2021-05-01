defmodule ChessWeb.GameController do
  alias ChessWeb.Router.Helpers, as: Routes
  alias ChessWeb.Endpoint


  use ChessWeb, :controller

  def new(conn, _params) do
    game_id = Chess.GameRegistry.create()
    redirect(conn, to: Routes.game_path(Endpoint, :show, game_id))
  end

  def show(conn, %{"id" => id}) do
    render(conn, "game.html")
  end
end
