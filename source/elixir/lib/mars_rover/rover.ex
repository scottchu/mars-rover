defmodule MarsRover.Rover do
  alias MarsRover.NavigationSystem.{Coordinate, Orientation}

  @enforce_keys [:coordinate, :orientation]
  defstruct [:coordinate, :orientation]

  @type t() :: %__MODULE__{
          coordinate: Coordinate.t(),
          orientation: Orientation.t()
        }

  @spec create(Coordinate.t(), Orientation.t()) :: t()
  def create(coordinate, orientation) do
    %__MODULE__{coordinate: coordinate, orientation: orientation}
  end

  @spec update(Coordinate.t(), :coordinate, t()) :: t()
  def update(coordinate, :coordinate, %__MODULE__{} = rover) do
    %__MODULE__{rover | coordinate: coordinate}
  end

  @spec update(Orientation.t(), :orientation, t()) :: t()
  def update(orientation, :orientation, %__MODULE__{} = rover) do
    %__MODULE__{rover | orientation: orientation}
  end
end
