defmodule Spender.Model do
  @moduledoc ~S"""
  Helper to get correct packages
  """
  
  @doc ~S"""
  When used import appropriate helper modules.
  """
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

    end
  end
end