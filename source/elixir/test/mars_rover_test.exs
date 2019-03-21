defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  test "greets the world" do
    assert MarsRover.hello() == :world
  end
end
