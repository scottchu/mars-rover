defmodule MarsRover.TwoDimension.OrientationTest do
  use ExUnit.Case, async: true
  doctest MarsRover.TwoDimension.Orientation

  alias MarsRover.{NavigationSystem, TwoDimension}

  describe("MarsRover.NavigationSystem.Orientation implementation") do

    test("turn -- left") do
      orientation = TwoDimension.Orientation.create(:north)
      assert NavigationSystem.Orientation.turn(orientation, :left) == %TwoDimension.Orientation{direction: :west}
    end

    test("turn -- right") do
      orientation = TwoDimension.Orientation.create(:north)
      assert NavigationSystem.Orientation.turn(orientation, :right) == %TwoDimension.Orientation{direction: :east}
    end

    test("turn -- from unknown direction") do
      orientation = TwoDimension.Orientation.create(:unknown)
      assert NavigationSystem.Orientation.turn(orientation, :right) == %TwoDimension.Orientation{direction: :unknown}
    end

    test("turn -- to unknown side") do
      orientation = TwoDimension.Orientation.create(:north)
      assert NavigationSystem.Orientation.turn(orientation, :unknown) == %TwoDimension.Orientation{direction: :north}
    end

  end
end
