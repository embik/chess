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
          true -> "fa-chess-" <> Atom.to_string(piece.class) <> " piece-" <> Atom.to_string(piece.color)
          false -> nil
        end
    end
  end

  def is_selected?(player, x, y) do
    case player.selected_field.x == x and player.selected_field.y == y do
      true -> "is-selected"
      false -> nil
    end
  end

  defp blank?(nil), do: true
  defp blank?(_), do: false
end
