defmodule TreeSitter.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_tree_sitter,
      version: "0.0.1-dev",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      compilers: [:elixir_make] ++ Mix.compilers(),
      deps: deps(),

      name: "TreeSitter",
      source_url: "https://github.com/bardoor/elixir-tree-sitter",
      docs: docs(),
      description: description(),
      package: package(),
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.9", runtime: false},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true},
    ]
  end

  defp docs do
    [
      main: "TreeSitter",
      logo: "static/elixir-tree-sitter.png",
      extras: ["README.md"]
    ]
  end

  defp description do
    "Elixir bindings for Tree-sitter parsing library"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "LICENSE*"],
      maintainers: ["bardoor"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/bardoor/elixir-tree-sitter"
      }
    ]
  end
end
