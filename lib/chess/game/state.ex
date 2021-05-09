defmodule Chess.Game.State do
  alias Chess.Game.State
  alias Chess.Game.Player
  alias Chess.Game.Board

  defstruct id: "", player1: %Player{}, player2: %Player{}, board: %Board{}

  def new() do
    %State{id: Ecto.UUID.generate(), board: Board.new(), player1: Player.new(:white), player2: Player.new(:black)}
  end
end
