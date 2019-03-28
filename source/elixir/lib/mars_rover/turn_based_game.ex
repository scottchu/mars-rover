defmodule MarsRover.TurnBasedGame do
  alias MarsRover.{Game, Instruction}

  @behaviour Game

  @impl Game
  @spec start(Game.t()) :: Game.t()
  def start(%Game{instructions: []} = game), do: game

  def start(%Game{world: world, instructions: [instruction | remaining_instructions]}) do
    instruction
    |> Instruction.perform(world)
    |> Game.create(remaining_instructions)
    |> start()
  end
end
