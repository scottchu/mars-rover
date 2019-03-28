defmodule MarsRover.Output do
  alias MarsRover.Game

  @callback write(Game.t(), (String.t() -> any())) ::
    {:ok, Game.t()}
    | {:error, term()}
end
