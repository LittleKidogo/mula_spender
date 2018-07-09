@moduledoc """
This module holds the schema and changeset functions for the LogCategory
"""
defmodule Spender.Planning.LogCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Budget
  }

  @type t :: %__MODULE__{}

  schema "logcategories" do
    field(:name, :string)
    belongs_to(:budget, Budget)
  end

  @doc """
  This changeset function takes in a struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  def changeset(logcategory, attrs \\ %{}) do
    logcategory
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 40)
  end
end
