defmodule NetLoad.MixProject do
  use Mix.Project

  def project do
    [
      app: :net_load,
      version: "0.1.0",
      elixir: "~> 1.11",
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
      {:load, github: "everknow/load"},
      {:ilp_packet, github: "everknow/ilp_packet"},
      {:uuid, "1.1.8"}
    ]
  end
end
