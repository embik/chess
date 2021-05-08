defmodule ChessWeb.GameView do
  use ChessWeb, :view

  def char(x) do
    List.to_string([x + 96])
  end

  def color(x, y) do
    case rem(x, 2)== rem(y, 2) do
      true -> 'black'
      false -> 'white'
    end
  end

  def get_piece(field, x, y) do
    piece = Map.get(field, {x, y})
    case blank?(piece) do
      true -> nil
      false ->
        case Map.has_key?(piece, :class) do
          true -> Atom.to_string(piece.class) <> "-" <> Atom.to_string(piece.color)
          false -> nil
        end
    end
  end

  defp blank?(nil), do: true
  defp blank?(_), do: false
end
