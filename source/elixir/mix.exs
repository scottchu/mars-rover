defmodule MarsRover.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_rover,
      version: "0.1.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
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

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

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
      exec: [
        "cmd clear",
        "build",
        "cmd #{@filepath}"
      ]
    ]
  end
end
