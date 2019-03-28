defmodule MarsRover.Instruction.RoverTest do
  use ExUnit.Case, async: true
  doctest MarsRover.Instruction.Rover

  alias MarsRover.{Instruction, TwoDimension, Rover, Rovers, World}

  describe("MarsRover.Instruction implementation") do

    test("perform instruction -- create rover") do
      instruction = Instruction.Rover.create(:create, [{5, 5}, :north])

      world = World.create()

      assert Instruction.perform(instruction, world) == %World{
        rovers: %Rovers{
          rovers: [
            Rover.create(
              TwoDimension.Coordinate.create(5, 5),
              TwoDimension.Orientation.create(:north)
            )
          ]
        }
      }
    end

    test("perform instruction -- move rover") do
      instruction = Instruction.Rover.create(:move, [0])

      rovers = Rovers.create([
        Rover.create(
          TwoDimension.Coordinate.create({5, 5}),
          TwoDimension.Orientation.create(:north)
        )
      ])

      world = World.create(nil, rovers)

      assert Instruction.perform(instruction, world) == %World{
        rovers: %Rovers{
          rovers: [
            Rover.create(
              TwoDimension.Coordinate.create(5, 6),
              TwoDimension.Orientation.create(:north)
            )
          ]
        }
      }
    end

    test("perform instruction -- turn rover") do
      instruction = Instruction.Rover.create(:left, [0])

      rovers = Rovers.create([
        Rover.create(
          TwoDimension.Coordinate.create({5, 5}),
          TwoDimension.Orientation.create(:west)
        )
      ])

      world = World.create(nil, rovers)

      assert Instruction.perform(instruction, world) == %World{
        rovers: %Rovers{
          rovers: [
            Rover.create(
              TwoDimension.Coordinate.create(5, 5),
              TwoDimension.Orientation.create(:south)
            )
          ]
        }
      }
    end

    test("perform instruction -- unknown action") do
      instruction = Instruction.Rover.create(:unknown, [0])

      rovers = Rovers.create([
        Rover.create(
          TwoDimension.Coordinate.create({5, 5}),
          TwoDimension.Orientation.create(:west)
        )
      ])

      world = World.create(nil, rovers)

      assert Instruction.perform(instruction, world) == world
    end
  end
end
