defprotocol MarsRover.Instruction do
  alias MarsRover.World

  @spec perform(t(), World.t()) :: World.t()
  def perform(instruction, world)
end
