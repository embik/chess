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


  @impl true
  def init(init_args) do
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
end
