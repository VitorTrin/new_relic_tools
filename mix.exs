defmodule NewRelicTools.MixProject do
  use Mix.Project

  def project do
    [
      app: :new_relic_tools,
      version: "1.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Tools to extend new_relic_agent",
      source_url: "https://github.com/VitorTrin/new_relic_tools",
      package: package()
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
      {:new_relic_agent, "~> 1.23.0-rc.5"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/VitorTrin/new_relic_tools",
        "New Relic Agent" => "https://github.com/newrelic/elixir_agent"
      }
    ]
  end
end
