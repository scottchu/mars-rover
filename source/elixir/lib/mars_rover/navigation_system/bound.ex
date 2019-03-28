defprotocol MarsRover.NavigationSystem.Bound do
  alias MarsRover.NavigationSystem.Coordinate

  @spec within?(t(), Coordinate.t()) :: boolean()
  def within?(bound, coordinate)

  @spec outof?(t(), Coordinate.t()) :: boolean()
  def outof?(bound, coordinate)
end
