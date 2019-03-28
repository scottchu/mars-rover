defprotocol MarsRover.NavigationSystem.Orientation do
  alias MarsRover.NavigationSystem.Coordinate

  @type side :: :left | :right

  @spec turn(t(), side()) :: t()
  def turn(orientation, to)

  @spec coordinate_delta(Orientation.t()) :: Coordinate.t()
  def coordinate_delta(orientation)
end
