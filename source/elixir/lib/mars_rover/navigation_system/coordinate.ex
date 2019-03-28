defprotocol MarsRover.NavigationSystem.Coordinate do
  alias MarsRover.NavigationSystem.Orientation

  @spec add(t(), t()) :: t()
  def add(lhs, rhs)

  @spec eq(t(), t()) :: t()
  def eq(lhs, rhs)

  @spec move(t(), Orientation.t()) :: t()
  def move(coordinate, orientation)
end
