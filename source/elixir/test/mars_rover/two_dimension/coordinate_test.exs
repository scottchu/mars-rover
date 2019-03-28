defmodule MarsRover.TwoDimension.CoordinateTest do
  use ExUnit.Case, async: true

  alias MarsRover.NavigationSystem
  alias MarsRover.TwoDimension.Coordinate

  describe("NavigationSystem.Coordinate implementation") do
    test("add") do
      lhs = %Coordinate{x: 8, y: 9}
      rhs = %Coordinate{x: 10, y: 9}

      assert %Coordinate{x: 18, y: 18} == NavigationSystem.Coordinate.add(lhs, rhs)
    end

    test("equality when equals") do
      lhs = %Coordinate{x: 10, y: 9}
      rhs = %Coordinate{x: 10, y: 9}

      assert NavigationSystem.Coordinate.eq(lhs, rhs)
    end

    test("equality when not equals") do
      lhs = %Coordinate{x: 8, y: 9}
      rhs = %Coordinate{x: 10, y: 9}

      refute NavigationSystem.Coordinate.eq(lhs, rhs)
    end
  end
end
