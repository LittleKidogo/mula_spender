defmodule Spender.Using.ExpenseLog do
  @moduledoc """
  This module holds changeset functions used to work with
  ExpenseLogs
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Budget
  }

  @type t :: %__MODULE__{}

  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "expenselogs" do
    field :name, :string
    field :desc, :string
    field :amount, :float
    field :expense_date, :date
    belongs_to :budget, Budget, foreign_key: :budget_id, type: :binary_id
  end

  @doc """
  This changeset function takes in a struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  @spec changeset(ExpenseLog.t(), map) :: Changeset.t()
  def changeset(expenselog, attrs \\ %{}) do
   expenselog
   |> cast(attrs, [:name, :desc, :amount])
   |> validate_required([:name, :amount])
 end
end
