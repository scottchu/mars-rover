defmodule MarsRover.Instruction.RoverTest do
  use MarsRover.GameCase,
    async: true,
    Bound: MarsRover.TwoDimension.Bound,
    Coordinate: MarsRover.TwoDimension.Coordinate,
    Orientation: MarsRover.TwoDimension.Orientation

  doctest MarsRover.Instruction.Rover

  describe("MarsRover.Instruction implementation") do
    test("perform instruction -- create rover") do
      instruction = Instruction.Rover.create(:create, [{5, 5}, :north])

      world = create_world(create_plateau({10, 10}))

      assert Instruction.perform(instruction, world) ==
               %World{world | rovers: create_rovers([{5, 5, :north}])}
    end

    test("perform instruction -- move rover") do
      instruction = Instruction.Rover.create(:move, [0])

      world =
        create_world(
          create_plateau({10, 10}),
          create_rovers([{5, 5, :north}])
        )

      assert Instruction.perform(instruction, world) ==
               %World{world | rovers: create_rovers([{5, 6, :north}])}
    end

    test("perform instruction -- turn rover") do
      instruction = Instruction.Rover.create(:left, [0])

      world =
        create_world(
          create_plateau({10, 10}),
          create_rovers([{5, 5, :west}])
        )

      assert Instruction.perform(instruction, world) ==
               %World{world | rovers: create_rovers([{5, 5, :south}])}
    end

    test("perform instruction -- unknown action") do
      instruction = Instruction.Rover.create(:unknown, [0])

      world = create_world(create_plateau({5, 5}), create_rovers([{5, 5, :west}]))

      assert Instruction.perform(instruction, world) ==
               world
    end
  end
end
