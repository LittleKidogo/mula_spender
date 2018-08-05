defmodule Spender.Using.ExpenseLog do
  @moduledoc """
  This module holds changeset functions used to work with
  ExpenseLogs
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    Planning.LogCategory,
    Using.ExpenseLog,
    MoneyLogs.Moneylog
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
    belongs_to :logcategory, LogCategory, foreign_key: :logcategory_id, type: :binary_id
    belongs_to :moneylog, Moneylog, foreign_key: :moneylog_id, type: :binary_id

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
 @spec create_changeset(Moneylog.t(), map) :: Changeset.t()
 def create_changeset(%Moneylog{} = moneylog, attrs) do
   %ExpenseLog{}
   |> ExpenseLog.changeset(attrs)
   |> put_assoc(:moneylog, moneylog)
  end
  @spec log_changeset(LogCategory.t(), map) :: Changeset.t()
  def log_changeset(%LogCategory{} = logcategory, attrs \\ %{}) do
    %ExpenseLog{}
    |> ExpenseLog.changeset(attrs)
   |> put_assoc(:logcategory, logcategory)
  end
end
