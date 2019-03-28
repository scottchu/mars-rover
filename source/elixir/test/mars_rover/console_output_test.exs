defmodule MarsRover.ConsoleOutputTest do
  use MarsRover.GameCase,
    async: true,
    Bound: MarsRover.TwoDimension.Bound,
    Coordinate: MarsRover.TwoDimension.Coordinate,
    Orientation: MarsRover.TwoDimension.Orientation

  describe("MarsRover.Output implementation") do
    test("write/1 with game") do
      plateau = create_plateau({10, 10})

      rovers = create_rovers([
        {5, 5, :north},
        {4, 3, :west}
      ])

      world = create_world(plateau, rovers)

      game = create_game(world)
      MarsRover.ConsoleOutput.write(game, fn output ->
        assert output == """
        = Game Output ========================================
        5, 5, north
        4, 3, west
        ======================================================
        """
      end)
    end
  end
end
