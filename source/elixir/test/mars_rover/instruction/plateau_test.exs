defmodule MarsRover.Instruction.PlateauTest do
  use ExUnit.Case, async: true
  doctest MarsRover.Instruction.Plateau

  alias MarsRover.{Instruction, Plateau, TwoDimension, World}

  describe("MarsRover.Instruction implementation") do
    test("perform instruction -- create plateau") do
      max = {10, 10}
      instruction = Instruction.Plateau.create(:create, max)
      world = World.create()

      assert Instruction.perform(instruction, world) == %World{
        plateau: %Plateau{
          bound: %TwoDimension.Bound{
            min: %TwoDimension.Coordinate{x: 0, y: 0},
            max: %TwoDimension.Coordinate{x: 10, y: 10}
          }
        }
      }
    end

    test("perform instruction -- unknown action") do
      instruction = Instruction.Plateau.create(:unknown, [])
      world = World.create()

      assert Instruction.perform(instruction, world) == world
    end
  end
end
