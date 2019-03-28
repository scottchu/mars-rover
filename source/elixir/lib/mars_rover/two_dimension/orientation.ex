defmodule MarsRover.TwoDimension.Orientation do
  alias MarsRover.TwoDimension.Coordinate

  @enforce_keys [:direction]
  defstruct [:direction]

  @type turn() ::
          :left | :right

  @type direction() ::
          :north | :east | :south | :west | :unknown

  @type t() :: %__MODULE__{
          direction: direction()
        }

  @doc """
  Returns a list of all possible directions

  ## Examples
  iex> MarsRover.TwoDimension.Orientation.directions()
  [:north, :east, :south, :west]
  """
  @directions [:north, :east, :south, :west]
  @spec directions() :: [direction()]
  def directions(), do: @directions

  @doc """
  ## Examples
  iex> MarsRover.TwoDimension.Orientation.create(:north)
  %MarsRover.TwoDimension.Orientation{direction: :north}

  iex> MarsRover.TwoDimension.Orientation.create(:random)
  %MarsRover.TwoDimension.Orientation{direction: :unknown}
  """
  @spec create(direction()) :: t()
  def create(direction) when direction in @directions do
    %__MODULE__{direction: direction}
  end

  def create(_), do: %__MODULE__{direction: :unknown}

  defimpl MarsRover.NavigationSystem.Orientation do

    @spec turn(@for.t(), @for.turn()) :: @for.t()
    def turn(%@for{direction: :unknown} = orientation, _) do
      orientation
    end

    def turn(%@for{direction: direction}, to) do
      %@for{direction: _turn(to, direction)}
    end

    @spec _turn(@for.turn(), @for.direction(), nonempty_list(@for.direction())) :: any()
    def _turn(to, direction, directions \\ @for.directions())
    def _turn(:right, direction, [direction, next_direction | _]), do: next_direction
    def _turn(:left, direction, [prev_direction, direction | _]), do: prev_direction

    def _turn(to, direction, _directions)
      when to not in [:left, :right],
      do: direction

    def _turn(to, direction, [head | tail]) do
      _turn(to, direction, tail ++ [head])
    end

    @spec coordinate_delta(@for.t()) :: Coordinate.t()
    def coordinate_delta(%@for{direction: direction}) do
      direction
      |> case do
        :north -> {0, 1}
        :east -> {1, 0}
        :south -> {0, -1}
        :west -> {-1, 0}
      end
      |> Coordinate.create()
    end
  end
end
