defmodule MarsRover.Game do
  alias MarsRover.{World}

  @enforce_keys [:world]
  defstruct [
    :world,
    instructions: []
  ]

  @type t() :: %__MODULE__{
          world: World.t(),
          instructions: [atom()]
        }

  @spec create(World.t(), [atom()]) :: t()
  def create(world, instructions \\ []) do
    %__MODULE__{world: world, instructions: instructions}
  end

  alias MarsRover.{Game, Instruction}

  @callback start(t()) :: t()

  @spec start(Game.t()) :: Game.t()
  def start(%Game{instructions: []} = game), do: game

  def start(%Game{world: world, instructions: [instruction | remaining_instructions]}) do
    instruction
    |> Instruction.perform(world)
    |> Game.create(remaining_instructions)
    |> start()
  end
end
