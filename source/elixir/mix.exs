defmodule MarsRover.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_rover,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}
    ]
  end

  @name "MarsRover"
  @filepath "./#{@name}"

  defp escript() do
    [
      main_module: MarsRover,
      name: @name
    ]
  end

  defp aliases() do
    [
      build: ["cmd rm -f #{@filepath}", "escript.build"],
      exec: ["build", "cmd #{@filepath}"]
    ]
  end
end
