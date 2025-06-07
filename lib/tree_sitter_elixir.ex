defmodule TreeSitter do
  @moduledoc """
  Bindings for TreeSitter

  > #### It is NIF library {: .warning}
  >
  > This library uses NIF to provide tree-sitter bindings,
  > so if there will be segmentation faults or any errors
  > on the NIF side - **it will crash whole Erlang VM**
  >
  > So wrap this library in a separate OS process using
  > `Ports` or something else to prevent VM crashes.

  Usage example:

  ```
  # Create parser
  parser = TreeSitter.new()

  # Create a language (check new_language/2 docs for more info)
  language = TreeSitter.new_language("./languages/libtree-sitter-css.dylib", "tree_sitter_css")

  # Set language to parser
  :ok = TreeSitter.set_language(parser, language)

  # Parse!
  {:ok, tree} = TreeSitter.parse_string(parser, "body {color: red}")

  # Covert to map or do queries
  {:ok, tree_map} = TreeSitter.to_map(tree)
  ```
  """

  @type parser :: reference()
  @type language :: reference()
  @type tree :: reference()

  @type query :: reference()
  @type capture :: {atom(), map()}
  @type captures :: [[capture()]]

  @type capture_result :: {:ok, captures()} | {:error, map()}

  @type string_like :: binary() | charlist()

  @compile {:autoload, false}
  @external_resource "../native/tree_sitter_elixir.so"
  @on_load {:load_nif, 0}

  def load_nif do
    path = Application.app_dir(:tree_sitter, ["priv", "native", "tree_sitter"])
    :ok = :erlang.load_nif(path, 0)
  end

  @doc """
  Initialize new parser

  You must set language (see `new_language/2` and `set_language/2`) to use it for parsing
  """
  def new, do: :erlang.nif_error(:not_loaded)

  @doc """
  Create language from compiled library (.so or .dylib).

  You can get it by running 'make' in root of some parser for tree sitter.

  # Params
  `library` - path to the compiled library file

  `function` - function name, based on library name. For example tree-sitter-css lib must have 'tree_sitter_css' function name
  """
  @spec new_language(string_like(), string_like()) :: language()
  def new_langauge(library, function) when is_list(library) or is_list(function) do
    new_langauge(
      to_charlist(library),
      to_charlist(function)
    )
  end

  def new_language(_library, _function), do: :erlang.nif_error(:not_loaded)

  @doc """
  Set lagnuage for given parser

  # Params

  `parser` - parser reference

  `language` - language reference, that you created with `new_language/2`
  """
  @spec set_language(parser(), language()) :: :ok
  def set_language(_parser, _language), do: :erlang.nif_error(:not_loaded)

  @doc """
  Parse string with given parser

  Remember that you should do `set_language/2` before
  """
  @spec parse_string(parser(), binary()) :: tree()
  def parse_string(_parser, _source_code), do: :erlang.nif_error(:not_loaded)

  @doc """
  Create new query for given language
  """
  @spec new_query(language(), binary()) :: query()
  def new_query(_language, _source), do: :erlang.nif_error(:not_loaded)

  @doc """
  Execute query for given tree
  """
  @spec exec_query(query(), tree()) :: capture_result()
  def exec_query(_query, _tree), do: :erlang.nif_error(:not_loaded)

  @doc """
  Convert native tree sitter tree to elixir map
  """
  @spec to_map(tree()) :: {:ok, map()} | {:error, map()}
  def to_map(_tree), do: :erlang.nif_error(:not_loaded)
end
