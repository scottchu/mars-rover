defmodule MarsRover.Rovers do
  alias MarsRover.Rover

  defstruct rovers: []

  @type t() :: %__MODULE__{
          rovers: [Rover.t()]
        }

  @spec create([Rover.t()]) :: t()
  def create(rovers \\ []) do
    %__MODULE__{rovers: rovers}
  end

  @spec lookup(t(), integer()) ::
          {:ok, Rover.t()}
          | {:error, :not_found}
  def lookup(%__MODULE__{rovers: rovers}, key) do
    case Enum.at(rovers, key) do
      nil ->
        {:error, :not_found}

      rover ->
        {:ok, rover}
    end
  end

  @spec update(Rover.t(), integer(), t()) :: t()
  def update(%Rover{} = rover, id, %__MODULE__{rovers: rovers}) do
    rovers
    |> List.replace_at(id, rover)
    |> create()
  end

  @spec insert(Rover.t(), t()) :: t()
  def insert(%Rover{} = rover, %__MODULE__{rovers: rovers}) do
    create(rovers ++ [rover])
  end
end
