defmodule MarsRover.TwoDimension.BoundTest do
  use ExUnit.Case, async: true

  alias MarsRover.NavigationSystem
  alias MarsRover.TwoDimension.{Bound, Coordinate}

  describe("MarsRover.NavigationSystem.Bound implementation") do
    test("within?/2 when within bound") do
      min = Coordinate.create(0, 0)
      max = Coordinate.create(10, 10)
      bound = Bound.create(min, max)

      assert NavigationSystem.within_bound?(bound, Coordinate.create(0, 0))
      assert NavigationSystem.within_bound?(bound, Coordinate.create(10, 10))
      assert NavigationSystem.within_bound?(bound, Coordinate.create(5, 6))
    end

    test("within?/2 when out of bound") do
      min = Coordinate.create(0, 0)
      max = Coordinate.create(10, 10)
      bound = Bound.create(min, max)

      refute NavigationSystem.within_bound?(bound, Coordinate.create(11, 5))
      refute NavigationSystem.within_bound?(bound, Coordinate.create(0, -1))
      refute NavigationSystem.within_bound?(bound, Coordinate.create(-20, 20))
    end

    test("outof?/2 when out of bound") do
      min = Coordinate.create(0, 0)
      max = Coordinate.create(10, 10)
      bound = Bound.create(min, max)

      assert NavigationSystem.outof_bound?(bound, Coordinate.create(11, 5))
      assert NavigationSystem.outof_bound?(bound, Coordinate.create(0, -1))
      assert NavigationSystem.outof_bound?(bound, Coordinate.create(-20, 20))
    end

    test("outof?/2 when within bound") do
      min = Coordinate.create(0, 0)
      max = Coordinate.create(10, 10)
      bound = Bound.create(min, max)

      refute NavigationSystem.outof_bound?(bound, Coordinate.create(0, 0))
      refute NavigationSystem.outof_bound?(bound, Coordinate.create(10, 10))
      refute NavigationSystem.outof_bound?(bound, Coordinate.create(5, 6))
    end
  end
end
