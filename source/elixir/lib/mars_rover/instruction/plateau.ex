defmodule MarsRover.Instruction.Plateau do
  alias MarsRover.TwoDimension.{Bound, Coordinate}
  alias MarsRover.{Plateau, World}

  @enforce_keys [:action, :args]
  defstruct [:action, :args]

  @type args() ::
          {integer(), integer()}
          | [{integer(), integer()}]

  @type action() ::
          :create

  @type t() :: %__MODULE__{
          action: action(),
          args: args()
        }

  @doc """
  ## Examples
  iex> MarsRover.Instruction.Plateau.create(:create, {10, 10})
  %MarsRover.Instruction.Plateau{action: :create, args: [{10, 10}]}

  iex> MarsRover.Instruction.Plateau.create(:create, [{0, 0}, {10, 10}])
  %MarsRover.Instruction.Plateau{action: :create, args: [{0, 0}, {10, 10}]}

  iex> MarsRover.Instruction.Plateau.create(:create, {0, 0}, {10, 10})
  %MarsRover.Instruction.Plateau{action: :create, args: [{0, 0}, {10, 10}]}
  """

  @spec create(action(), args()) :: t()
  @spec create(action(), args(), args()) :: t()
  def create(action, {_, _} = arg) do
    %__MODULE__{action: action, args: [arg]}
  end

  def create(action, [{_, _}, {_, _}] = args) do
    %__MODULE__{action: action, args: args}
  end

  def create(action, _),
    do: %__MODULE__{action: action, args: []}

  def create(action, {_, _} = min, {_, _} = max) do
    %__MODULE__{action: action, args: [min, max]}
  end

  defimpl MarsRover.Instruction do

    @spec perform(@for.t(), World.t()) :: World.t()
    def perform(%@for{action: action, args: args}, %World{} = world) do
      _perform(action, args, world)
    end

    defp _perform(:create, args, world) do
      args
      |> create_plateau()
      |> World.update(:plateau, world)
    end

    defp _perform(_action, _args, world), do: world

    @spec create_plateau([@for.arg()]) :: Plateau.t()
    defp create_plateau(args) do
      args
      |> Enum.map(&Coordinate.create/1)
      |> Enum.take(2)
      |> Bound.create()
      |> Plateau.create()
    end
  end
end
