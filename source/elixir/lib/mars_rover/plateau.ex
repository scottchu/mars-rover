defmodule MarsRover.Plateau do
  alias MarsRover.NavigationSystem.Bound

  @enforce_keys [:bound]
  defstruct [:bound]

  @type t() :: %__MODULE__{
          bound: Bound.t()
        }

  @spec create(Bound.t()) :: t()
  def create(bound) do
    %__MODULE__{bound: bound}
  end
end
