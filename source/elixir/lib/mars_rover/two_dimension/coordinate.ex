defmodule MarsRover.TwoDimension.Coordinate do
  alias MarsRover.TwoDimension.Orientation

  @enforce_keys [:x, :y]
  defstruct [:x, :y]

  @type t() :: %__MODULE__{
          x: integer(),
          y: integer()
        }

  @spec create() :: t()
  @spec create({integer(), integer()}) :: t()
  @spec create(integer(), integer()) :: t()

  def create(), do: create(0, 0)

  def create({x, y}) when is_integer(x) and is_integer(y) do
    %__MODULE__{x: x, y: y}
  end

  def create(x, y) when is_integer(x) and is_integer(y) do
    %__MODULE__{x: x, y: y}
  end

  defimpl MarsRover.NavigationSystem.Coordinate do

    @spec add(@for.t(), @for.t()) :: @for.t()
    def add(%@for{x: lhs_x, y: lhs_y}, %@for{x: rhs_x, y: rhs_y}) do
      %@for{x: lhs_x + rhs_x, y: lhs_y + rhs_y}
    end

    @spec eq(@for.t(), @for.t()) :: boolean()
    def eq(%@for{x: lhs_x, y: lhs_y}, %@for{x: rhs_x, y: rhs_y}) do
      lhs_x == rhs_x && lhs_y == rhs_y
    end

    @spec move(@for.t(), Orientation.t()) :: @for.t()
    def move(%@for{} = coordinate, %Orientation{} = orientation) do
      __MODULE__.add(
        coordinate,
        MarsRover.NavigationSystem.Orientation.coordinate_delta(orientation)
      )
    end
  end
end
