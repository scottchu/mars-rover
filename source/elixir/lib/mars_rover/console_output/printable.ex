defprotocol MarsRover.ConsoleOutput.Printable do

  @spec serialize(t()) :: String.t()
  def serialize(term)

end
