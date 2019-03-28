defmodule MarsRover.Game do
  alias MarsRover.{World}

  @callback start(t()) :: t()

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
end
