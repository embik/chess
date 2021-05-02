defmodule ChessWeb.GameController do
  alias ChessWeb.Router.Helpers, as: Routes
  alias ChessWeb.Endpoint


  use ChessWeb, :controller

  def new(conn, _params) do
    game_id = Chess.GameRegistry.create()
    redirect(conn, to: Routes.live_path(Endpoint, ChessWeb.GameLive, game_id))
  end
end
