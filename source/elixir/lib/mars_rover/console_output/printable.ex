defprotocol MarsRover.ConsoleOutput.Printable do

  @spec serialize(t()) :: String.t()
  def serialize(term)

end

defimpl MarsRover.ConsoleOutput.Printable, for: String do
  def serialize(term), do: term
end

defimpl MarsRover.ConsoleOutput.Printable, for: MarsRover.TwoDimension.Coordinate do
  alias MarsRover.TwoDimension.Coordinate

  def serialize(%Coordinate{x: x, y: y}), do: "#{x}, #{y}"
end

defimpl MarsRover.ConsoleOutput.Printable, for: MarsRover.TwoDimension.Orientation do
  alias MarsRover.TwoDimension.Orientation

  def serialize(%Orientation{direction: direction}), do: "#{direction}"
end

defimpl MarsRover.ConsoleOutput.Printable, for: MarsRover.Rover do
  alias MarsRover.Rover

  def serialize(%Rover{coordinate: coordinate, orientation: orientation}) do
    [coordinate, orientation]
    |> Enum.map(&MarsRover.ConsoleOutput.Printable.serialize/1)
    |> Enum.join(", ")
  end
end

defimpl MarsRover.ConsoleOutput.Printable, for: MarsRover.World do
  alias MarsRover.Rovers
  alias MarsRover.World

  def serialize(%World{rovers: %Rovers{rovers: rovers}}) do
    rovers
    |> Enum.map(&MarsRover.ConsoleOutput.Printable.serialize/1)
    |> Enum.join("\n")
  end
end

defimpl MarsRover.ConsoleOutput.Printable, for: MarsRover.Game do
  alias MarsRover.Game

  def serialize(%Game{world: world}) do
    MarsRover.ConsoleOutput.Printable.serialize(world)
  end
end
