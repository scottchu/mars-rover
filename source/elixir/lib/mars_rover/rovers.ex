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

  @spec collide?(Rover.t(), term(), t()) :: boolean()
  def collide?(%Rover{} = rover, id, %__MODULE__{rovers: rovers}) do
    rovers
    |> Enum.with_index()
    |> _collide?(rover, id)
  end

  @spec _collide?([Rover.t()], Rover.t(), term()) :: boolean()
  defp _collide?([], _rover, _id),
    do: false

  defp _collide?([{_, index} | tail], rover, index),
    do: _collide?(tail, rover, index)

  defp _collide?(
         [{%Rover{coordinate: coordinate}, _index} | _tail],
         %Rover{coordinate: coordinate},
         _id
       ),
       do: true

  defp _collide?([_ | tail], rover, id),
    do: _collide?(tail, rover, id)
end
