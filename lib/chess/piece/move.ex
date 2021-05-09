defmodule Chess.Piece.Move do
  alias Chess.Piece.Pawn

  def is_valid_move?(%Pawn{} = pawn, field, {start_x, start_y}, {x, y}) do
    start_x == x and y - start_y == 1
  end

  # fallback for unimplemented pieces
  def is_valid_move?(_, _, _, _), do: true
end
