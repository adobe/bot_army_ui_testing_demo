defmodule BotArmyStarter.MixProject do
  use Mix.Project

  def project do
    [
      app: :bot_army_starter,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:credo, "~> 1.1", only: [:dev, :test]},
      {:bot_army, "~> 1.0"},
      {:hound, "~> 1.1"}
    ]
  end
end
