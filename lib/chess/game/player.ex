defmodule Chess.Game.Player do
  alias Chess.Game.Player

  defstruct name: ""

  def new() do
    %Player{}
  end
end
