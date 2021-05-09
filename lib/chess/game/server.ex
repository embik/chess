defmodule Chess.Game.Server do
  alias Chess.Game

  use GenServer

  def start_link(init_args) do
    GenServer.start_link(__MODULE__, init_args)
  end

  def get_id(server) do
    GenServer.call(server, :get_id)
  end

  def get_board(server) do
    GenServer.call(server, :get_board)
  end

  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  def select_field(server, :player1, x, y) do
    GenServer.call(server, {:select_field, x, y})
  end


  @impl true
  def init(_init_args) do
    {:ok, Game.State.new()}
  end

  @impl true
  def handle_call(:get_id, _from, state) do
    {:reply, state.id, state}
  end

  @impl true
  def handle_call(:get_board, _from, state) do
    {:reply, state.board, state}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:select_field, x, y}, _from, state) do
    case has_player_piece?(state.board.field, state.player1, x, y) do
      true ->
        case state.player1.selected_field.x == x and state.player1.selected_field.y == y do
          true ->
            # selecting the same field as before will unselect it
            state
            |> set_selected_field(:white, 0, 0)
            |> return_state
          false ->
            # player is selecting another piece
            state
            |> set_selected_field(:white, x, y)
            |> return_state
        end
      false ->
        case state.player1.selected_field.x == 0 and state.player1.selected_field.y == 0 do
          true ->
            # selecting a non-valid field, do nothing
            state
            |> return_state
          false ->
            # player is making a move
            state
            |> move_piece(x, y)
            |> return_state
        end
    end
  end

  defp has_player_piece?(field, player, x, y) do
    piece = Map.get(field, {x, y})
    case piece do
      nil -> false
      _ -> player.color == piece.color
    end
  end

  defp get_piece(field, x, y) do
    piece = Map.get(field, {x, y})
    case piece do
      nil -> raise "no piece at " <> x <> "/" <> y
      _ -> {piece, x, y}
    end
  end

  defp move_piece(state, x, y) do
    field = get_piece(state.board.field, state.player1.selected_field.x, state.player1.selected_field.y)
            |> update_field(state.board.field, x, y)

    state
      |> set_selected_field(:white, 0, 0)
      |> Map.update(:round, 0, fn x -> x + 1 end)
      |> set_field(field)
  end

  defp update_field({piece, start_x, start_y}, field, x, y) do
  field
    |> Map.put({x, y}, piece)
    |> Map.put({start_x, start_y}, nil)
  end

  defp set_field(state, field) do
    board = %{state.board | field: field}
    %{state | board: board}
  end

  defp set_selected_field(state, player, x, y) do
    case player do
      :white ->
        player1 = %{state.player1 | selected_field: %{:x => x, :y => y}}
        %{state | player1: player1}
      :black ->
        player2 = %{state.player2 | selected_field: %{:x => x, :y => y}}
        %{state | player1: player2}
    end
  end

  defp return_state(state) do
    {:reply, state, state}
  end
end
