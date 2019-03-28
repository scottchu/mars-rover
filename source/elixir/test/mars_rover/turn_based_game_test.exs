defmodule MarsRover.TurnBasedGameTest do
  use MarsRover.GameCase,
    async: true,
    Bound: MarsRover.TwoDimension.Bound,
    Coordinate: MarsRover.TwoDimension.Coordinate,
    Orientation: MarsRover.TwoDimension.Orientation

  alias MarsRover.{
    Game,
    Plateau,
    Rover,
    Rovers,
    World,
    Instruction,
    TurnBasedGame
  }

  describe("Game.start/1 behaviour") do
    test("instructions -- no instructions") do
      plateau = create_plateau({10, 10})

      rovers = create_rovers([
        {10, 10, :south},
        {5, 5, :east}
      ])

      world = create_world(plateau, rovers)
      game = create_game(world, [])

      assert TurnBasedGame.start(game) == game
    end

    test("instructions -- from README example") do
      insturctions = [
        Instruction.Plateau.create(:create, {5, 5}),
        Instruction.Rover.create(:create, [{1, 2}, :north]),
        Instruction.Rover.create(:left, [0]),
        Instruction.Rover.create(:move, [0]),
        Instruction.Rover.create(:left, [0]),
        Instruction.Rover.create(:move, [0]),
        Instruction.Rover.create(:left, [0]),
        Instruction.Rover.create(:move, [0]),
        Instruction.Rover.create(:left, [0]),
        Instruction.Rover.create(:move, [0]),
        Instruction.Rover.create(:move, [0]),
        Instruction.Rover.create(:create, [{3, 3}, :east]),
        Instruction.Rover.create(:move, [1]),
        Instruction.Rover.create(:move, [1]),
        Instruction.Rover.create(:right, [1]),
        Instruction.Rover.create(:move, [1]),
        Instruction.Rover.create(:move, [1]),
        Instruction.Rover.create(:right, [1]),
        Instruction.Rover.create(:move, [1]),
        Instruction.Rover.create(:right, [1]),
        Instruction.Rover.create(:right, [1]),
        Instruction.Rover.create(:move, [1]),
      ]

      world = create_world()
      game = create_game(world, insturctions)

      new_rovers = create_rovers([
        {1, 3, :north},
        {5, 1, :east}
      ])

      expected_game =
        {5, 5}
        |> create_plateau()
        |> create_world(new_rovers)
        |> create_game([])

      assert TurnBasedGame.start(game) == expected_game
    end

    # test("instructions -- with invalid landing coordinate") do
    #   plateau = create_plateau({10, 10})
    #   world = create_world(plateau)

    #   instructions = [
    #     Instruction.Rover.create(:create, [{11, 10}])
    #   ]

    #   game = create_game(world, instructions)

    #   IO.inspect(game)

    #   assert TurnBasedGame.start(game)
    # end

    # test("instructions -- with out of bound check")

    # test("instructions -- with colliding check")
  end
end
