defmodule MarsRover.GameCase do
  use ExUnit.CaseTemplate

  defp async(boolean) do
    quote do
      use ExUnit.Case, async: unquote(boolean)
    end
  end

  defp alias_module(module) do
    quote do
      alias unquote(module)
    end
  end

  using(opts) do
    quote do
      unquote(async(opts[:async]))

      alias MarsRover.{
        Game,
        Instruction,
        Plateau,
        NavigationSystem,
        Rover,
        Rovers,
        World
      }

      unquote(alias_module(opts[:Bound]))
      unquote(alias_module(opts[:Coordinate]))
      unquote(alias_module(opts[:Orientation]))

      def create_rover(x, y, direction) do
        coordinate = Coordinate.create(x, y)
        orientation = Orientation.create(direction)
        Rover.create(coordinate, orientation)
      end

      def create_rovers(list \\ [], rovers \\ Rovers.create())
      def create_rovers([], %Rovers{} = rovers), do: rovers
      def create_rovers([{x, y, direction} | tail], %Rovers{} = rovers) do
        rovers =
          create_rover(x, y, direction)
          |> Rovers.insert(rovers)

        create_rovers(tail, rovers)
      end

      def create_plateau({x, y}) do
        {x, y}
        |> Coordinate.create()
        |> Bound.create()
        |> Plateau.create()
      end

      def create_world(plateau \\ nil, rovers \\ Rovers.create()) do
        World.create(plateau, rovers)
      end

      def create_game(world, instructions) do
        Game.create(world, instructions)
      end
    end
  end
end
