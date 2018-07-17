defmodule Spender.Using.CreateSavingsLog do
  @moduledoc """
  This module defines the layout and functions of the SavingsLog
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Budget
    Planning.LogCategories
  }

  schema "savingslog" do
    field :name, :string
    field :amount, :float
    belongs_to(:logcategories, LogCategories)
    belongs_to(:budget, Budget)
  end
end
