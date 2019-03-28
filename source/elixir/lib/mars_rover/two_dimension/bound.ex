defmodule MarsRover.TwoDimension.Bound do
  alias MarsRover.TwoDimension.Coordinate

  @enforce_keys []
  defstruct [:min, :max]

  @type t() :: %__MODULE__{
          min: Coordinate.t(),
          max: Coordinate.t()
        }

  @origin Coordinate.create()
  @spec create([Coordinate.t()]) :: t()
  def create([max | []]), do: create(max)
  def create([min, max | _]), do: create(min, max)

  @spec create(Coordinate.t()) :: t()
  @spec create(Coordinate.t(), Coordinate.t()) :: t()
  def create(min \\ @origin, max)

  def create(%Coordinate{} = min, %Coordinate{} = max),
    do: %__MODULE__{min: min, max: max}

  defimpl MarsRover.NavigationSystem.Bound do
    def within?(%@for{min: min, max: max}, %Coordinate{} = coordinate) do
      min.x <= coordinate.x && min.y <= coordinate.y &&
        (max.x >= coordinate.x && max.y >= coordinate.y)
    end

    def outof?(%@for{} = bound, %Coordinate{} = coordinate) do
      !within?(bound, coordinate)
    end
  end
end
