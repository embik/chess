defmodule Chess.Game.Board do
  alias Chess.Game.Board
  alias Chess.Piece

  defstruct field: %{}

  def new() do
    coordinates = for x <- 1..8, y <- 1..8, do: {x, y}

    field = Enum.reduce(coordinates, %{}, fn x, acc -> Map.put(acc, x, nil) end)
            |> Map.put({1, 1}, %Piece.Rook{color: :white})
            |> Map.put({1, 2}, %Piece.Knight{color: :white})
            |> Map.put({1, 3}, %Piece.Bishop{color: :white})
            |> Map.put({1, 4}, %Piece.Queen{color: :white})
            |> Map.put({1, 5}, %Piece.King{color: :white})
            |> Map.put({1, 6}, %Piece.Bishop{color: :white})
            |> Map.put({1, 7}, %Piece.Knight{color: :white})
            |> Map.put({1, 8}, %Piece.Rook{color: :white})
            |> Map.put({2, 1}, %Piece.Pawn{color: :white})
            |> Map.put({2, 2}, %Piece.Pawn{color: :white})
            |> Map.put({2, 3}, %Piece.Pawn{color: :white})
            |> Map.put({2, 4}, %Piece.Pawn{color: :white})
            |> Map.put({2, 5}, %Piece.Pawn{color: :white})
            |> Map.put({2, 6}, %Piece.Pawn{color: :white})
            |> Map.put({2, 7}, %Piece.Pawn{color: :white})
            |> Map.put({2, 8}, %Piece.Pawn{color: :white})
            |> Map.put({7, 1}, %Piece.Pawn{color: :black})
            |> Map.put({7, 2}, %Piece.Pawn{color: :black})
            |> Map.put({7, 3}, %Piece.Pawn{color: :black})
            |> Map.put({7, 4}, %Piece.Pawn{color: :black})
            |> Map.put({7, 5}, %Piece.Pawn{color: :black})
            |> Map.put({7, 6}, %Piece.Pawn{color: :black})
            |> Map.put({7, 7}, %Piece.Pawn{color: :black})
            |> Map.put({7, 8}, %Piece.Pawn{color: :black})
            |> Map.put({8, 1}, %Piece.Rook{color: :black})
            |> Map.put({8, 2}, %Piece.Knight{color: :black})
            |> Map.put({8, 3}, %Piece.Bishop{color: :black})
            |> Map.put({8, 4}, %Piece.Queen{color: :black})
            |> Map.put({8, 5}, %Piece.King{color: :black})
            |> Map.put({8, 6}, %Piece.Bishop{color: :black})
            |> Map.put({8, 7}, %Piece.Knight{color: :black})
            |> Map.put({8, 8}, %Piece.Rook{color: :black})

    %Board{field: field}
  end
end
