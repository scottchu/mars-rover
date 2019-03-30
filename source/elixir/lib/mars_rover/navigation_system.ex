defmodule MarsRover.NavigationSystem do
  alias MarsRover.{
    Plateau,
    Rover
  }

  alias MarsRover.NavigationSystem.{
    Bound,
    Coordinate,
    Orientation
  }

  @spec within_bound?(Rover.t(), Plateau.t()) :: boolean()
  def within_bound?(_rover, nil), do: false
  def within_bound?(%Rover{coordinate: coordinate}, %Plateau{bound: bound}), do: Bound.within?(bound, coordinate)

  @spec outof_bound?(Plateau.t(), Rover.t()) :: boolean()
  def outof_bound?(nil, _rover),
    do: true

  def outof_bound?(%Plateau{bound: bound}, %Rover{coordinate: coordinate}) do
    !within_bound?(bound, coordinate)
  end

  @spec move(Rover.t()) :: Rover.t()
  def move(%Rover{coordinate: coordinate, orientation: orientation} = rover) do
    coordinate
    |> Coordinate.move(orientation)
    |> Rover.update(:coordinate, rover)
  end

  @spec turn(Rover.t(), Orientation.side()) :: Rover.t()
  def turn(%Rover{orientation: orientation} = rover, to) when to in [:left, :right] do
    orientation
    |> Orientation.turn(to)
    |> Rover.update(:orientation, rover)
  end

  def turn(%Rover{} = rover, _to), do: rover
end
