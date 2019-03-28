defmodule MarsRover.World do
  alias MarsRover.{Plateau, Rovers}

  defstruct plateau: nil,
            rovers: Rovers.create()

  @type t() :: %__MODULE__{
          plateau: Plateau.t() | nil,
          rovers: Rovers.t()
        }

  @spec create(Plateau.t() | nil, Rovers.t()) :: t()
  def create(plateau \\ nil, rovers \\ Rovers.create())

  def create(plateau, rovers) do
    %__MODULE__{plateau: plateau, rovers: rovers}
  end

  @spec update(Plateau.t() | nil, :plateau, t()) :: t()
  @spec update(Rovers.t(), :rovers, t()) :: t()
  def update(%Plateau{} = plateau, :plateau, %__MODULE__{} = world) do
    %__MODULE__{world | plateau: plateau}
  end

  def update(%Rovers{} = rovers, :rovers, %__MODULE__{} = world) do
    %__MODULE__{world | rovers: rovers}
  end
end
