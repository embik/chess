defmodule Chess.Game.Board do
  alias Chess.Game.Board

  defstruct field: %{}

  def new() do
    coordinates = for x <- 1..8, y <- 1..8, do: {x, y}

    field = Enum.reduce coordinates, %{}, fn x, acc ->
      Map.put(acc, x, 0)
    end

    %Board{field: field}
  end
end
