defmodule Chess.Game.Player do
  alias Chess.Game.Player

  defstruct [:color, name: "", selected_field: %{:x => 0, :y => 0}]

  def new(color) do
    %Player{color: color}
  end
end
