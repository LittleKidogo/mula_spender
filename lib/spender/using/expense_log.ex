defmodule Spender.Using.ExpenseLog do
  @moduledoc """
  This module holds changeset functions used to work with
  ExpenseLogs
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Budget
    Planning.LogCategory,
    Using.ExpenseLog,
    Using.PaymentMethod
  }

  @type t :: %__MODULE__{}

  # binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "expenselogs" do
    field(:name, :string)
    field(:desc, :string)
    field(:amount, :float)
    field(:expense_date, :date)
    belongs_to(:budget, Budget, foreign_key: :budget_id, type: :binary_id)
    belongs_to(:logcategory, LogCategory, foreign_key: :logcategory_id, type: :binary_id)
    belongs_to(:paymentmethod, PaymentMethod, foreign_key: :paymentmethod_id, type: :binary_id)
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

  @doc """
  This changeset function takes in a budget struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  @spec create_changeset(Budget.t(), map) :: Changeset.t()
  def create_changeset(%Budget{} = budget, attrs) do
    %ExpenseLog{}
    |> ExpenseLog.changeset(attrs)
    |> put_assoc(:budget, budget)
  end

  @doc """
  This changeset function takes in a logcategory struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  @spec log_changeset(LogCategory.t(), map) :: Changeset.t()
  def log_changeset(%LogCategory{} = logcategory, attrs \\ %{}) do
    %ExpenseLog{}
    |> ExpenseLog.changeset(attrs)
    |> put_assoc(:logcategory, logcategory)
  end

  @doc """
  This changeset function takes in a paymentmethod struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  @spec payment_changeset(PaymentMethod.t(), map) :: Changeset.t()
  def payment_changeset(%PaymentMethod{} = paymentmethod, attrs \\ %{}) do
    %ExpenseLog{}
    |> ExpenseLog.changeset(attrs)
    |> put_assoc(:paymentmethod, paymentmethod)
  end
end
