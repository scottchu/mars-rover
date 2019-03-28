defmodule MarsRover.ConsoleOutput do
  @behaviour MarsRover.Output

  alias MarsRover.{ConsoleOutput, Game}

  @impl MarsRover.Output
  @spec write(Game.t(), (String.t() -> any())) ::
    {:ok, Game.t()}
    | {:error, term()}
  def write(%Game{} = game, printer) do
    [
      "= Game Output ========================================",
      ConsoleOutput.Printable.serialize(game),
      "======================================================\n"
    ]
    |> Enum.join("\n")
    |> printer.()

    {:ok, game}
  end
end
