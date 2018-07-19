defmodule Spender.Using.SavingsLog do
  @moduledoc """
  This module defines the layout and functions of the SavingsLog
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Budget,
    Planning.LogCategory
  }

  schema "savings_log" do
    field(:name, :string)
    field(:amount, :float)
    belongs_to(:logcategory, LogCategory)
    belongs_to(:budget, Budget)
  end

  @doc """
  This changeset function takes in a struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  @spec changeset(SavingsLog.t(), map) :: Changeset.t()
  def changeset(savings_log, attrs \\ %{}) do
    savings_log
    |> cast(attrs, [:name, :amount])
    |> validate_required([:name, :amount])
  end
end
