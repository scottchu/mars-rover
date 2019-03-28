defmodule MarsRover.Instruction.Rover do
  alias MarsRover.{NavigationSystem, Rover, Rovers, World}
  alias MarsRover.TwoDimension.{Coordinate, Orientation}

  @enforce_keys [:action, :args]
  defstruct [:action, :args]

  @type action() :: atom()
  @type args() :: [any()]

  @type t() :: %__MODULE__{
          action: action(),
          args: args()
        }

  @doc """
  ## Examples
  iex> MarsRover.Instruction.Rover.create(:create, [])
  %MarsRover.Instruction.Rover{action: :create, args: []}

  iex> MarsRover.Instruction.Rover.create(:create, [{10, 10}])
  %MarsRover.Instruction.Rover{action: :create, args: [{10, 10}]}
  """
  @spec create(action(), args()) :: t()
  def create(action, args \\ []) do
    %__MODULE__{action: action, args: args}
  end

  defimpl MarsRover.Instruction do

    @spec perform(@for.t(), World.t()) :: World.t()
    def perform(%@for{action: action, args: args}, %World{} = world) do
      _perform(action, args, world)
    end

    @spec _perform(atom(), @for.args(), World.t()) :: World.t()
    defp _perform(:create, [point, direction | _], %World{rovers: rovers} = world) do
      coordinate = Coordinate.create(point)
      orientation = Orientation.create(direction)

      Rover.create(coordinate, orientation)
      |> Rovers.insert(rovers)
      |> World.update(:rovers, world)
    end

    defp _perform(:move, [rover_id], %World{rovers: rovers} = world) do
      case Rovers.lookup(rovers, rover_id) do
        {:ok, %Rover{coordinate: coordinate, orientation: orientation} = rover} ->
          coordinate
          |> NavigationSystem.move(orientation)
          |> Rover.update(:coordinate, rover)
          |> Rovers.replace(rover_id, rovers)
          |> World.update(:rovers, world)

        {:error, _} ->
          world
      end
    end

    defp _perform(action, [rover_id], %World{rovers: rovers} = world) when action in [:left, :right]  do
      case Rovers.lookup(rovers, rover_id) do
        {:ok, %Rover{orientation: orientation} = rover} ->
          orientation
          |> NavigationSystem.turn(action)
          |> Rover.update(:orientation, rover)
          |> Rovers.replace(rover_id, rovers)
          |> World.update(:rovers, world)
        {:error, _} ->
          world
      end
    end

    defp _perform(_action, _args, world), do: world

  end
end
