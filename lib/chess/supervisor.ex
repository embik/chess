defmodule Chess.GameRegistry do
  use Supervisor

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the game pid for `id` stored in `server`.

  Returns `{:ok, pid}` if the game exists, `:error` otherwise.
  """
  def lookup(id) do
    GenServer.call(Chess.GameRegistry, {:lookup, id})
  end

  @doc """
  Ensures there is a game associated with the given `id` in `server`.
  """
  def create() do
    GenServer.call(Chess.GameRegistry, :create)
  end

  @impl true
  def init(:ok) do
    games = %{}
    refs = %{}
    {:ok, {games, refs}}
  end

  def handle_call({:lookup, id}, _from, state) do
    {games, _} = state
    {:reply, Map.fetch(games, id), state}
  end

  def handle_call(:create, _from, {games, refs}) do
    {:ok, pid} = DynamicSupervisor.start_child(Chess.DynamicGameSupervisor, Chess.Game.Server)

    id = Chess.Game.Server.get_id(pid)
    ref = Process.monitor(pid)
    refs = Map.put(refs, ref, id)
    games = Map.put(games, id, pid)

    {:reply, id, {games, refs}}
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {games, refs}) do
    {game, refs} = Map.pop(refs, ref)
    games = Map.delete(games, game)
    {:noreply, {games, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end

defmodule Chess.GameSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {Chess.GameRegistry, name: Chess.GameRegistry},
      {DynamicSupervisor, name: Chess.DynamicGameSupervisor, strategy: :one_for_one}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
