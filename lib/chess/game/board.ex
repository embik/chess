defmodule Chess.Game.Board do
  alias Chess.Game.Board

  defstruct field: %{}

  def new() do
    %Board{}
  end
end
