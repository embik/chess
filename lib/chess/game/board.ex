defmodule Chess.Game.Board do
  alias Chess.Game.Board
  alias Chess.Piece

  defstruct field: %{}

  def new() do
    coordinates = for x <- 1..8, y <- 1..8, do: {x, y}

    field = Enum.reduce(coordinates, %{}, fn x, acc -> Map.put(acc, x, nil) end)
            |> Map.put({1, 1}, %Piece.Rook{color: :white})
            |> Map.put({2, 1}, %Piece.Knight{color: :white})
            |> Map.put({3, 1}, %Piece.Bishop{color: :white})
            |> Map.put({4, 1}, %Piece.Queen{color: :white})
            |> Map.put({5, 1}, %Piece.King{color: :white})
            |> Map.put({6, 1}, %Piece.Bishop{color: :white})
            |> Map.put({7, 1}, %Piece.Knight{color: :white})
            |> Map.put({8, 1}, %Piece.Rook{color: :white})
            |> Map.put({1, 2}, %Piece.Pawn{color: :white})
            |> Map.put({2, 2}, %Piece.Pawn{color: :white})
            |> Map.put({3, 2}, %Piece.Pawn{color: :white})
            |> Map.put({4, 2}, %Piece.Pawn{color: :white})
            |> Map.put({5, 2}, %Piece.Pawn{color: :white})
            |> Map.put({6, 2}, %Piece.Pawn{color: :white})
            |> Map.put({7, 2}, %Piece.Pawn{color: :white})
            |> Map.put({8, 2}, %Piece.Pawn{color: :white})
            |> Map.put({1, 7}, %Piece.Pawn{color: :black})
            |> Map.put({2, 7}, %Piece.Pawn{color: :black})
            |> Map.put({3, 7}, %Piece.Pawn{color: :black})
            |> Map.put({4, 7}, %Piece.Pawn{color: :black})
            |> Map.put({5, 7}, %Piece.Pawn{color: :black})
            |> Map.put({6, 7}, %Piece.Pawn{color: :black})
            |> Map.put({7, 7}, %Piece.Pawn{color: :black})
            |> Map.put({8, 7}, %Piece.Pawn{color: :black})
            |> Map.put({1, 8}, %Piece.Rook{color: :black})
            |> Map.put({2, 8}, %Piece.Knight{color: :black})
            |> Map.put({3, 8}, %Piece.Bishop{color: :black})
            |> Map.put({4, 8}, %Piece.Queen{color: :black})
            |> Map.put({5, 8}, %Piece.King{color: :black})
            |> Map.put({6, 8}, %Piece.Bishop{color: :black})
            |> Map.put({7, 8}, %Piece.Knight{color: :black})
            |> Map.put({8, 8}, %Piece.Rook{color: :black})

    %Board{field: field}
  end
end
