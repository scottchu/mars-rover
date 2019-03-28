defmodule MarsRover.NavigationSystem do
  alias MarsRover.NavigationSystem.{Bound, Coordinate, Orientation}

  @spec within_bound?(Bound.t(), Coordinate.t()) :: boolean()
  def within_bound?(bound, coordinate) do
    Bound.within?(bound, coordinate)
  end

  @spec outof_bound?(Bound.t(), Coordinate.t()) :: boolean()
  def outof_bound?(bound, coordinate) do
    Bound.outof?(bound, coordinate)
  end

  @spec move(Coordinate.t(), Orientation.t()) :: Coordinate.t()
  def move(coordinate, orientation) do
    Coordinate.move(coordinate, orientation)
  end

  @spec turn(Orientation.t(), Orientation.side()) :: Orientation.t()
  def turn(orientation, to) do
    Orientation.turn(orientation, to)
  end
end
