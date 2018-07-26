defmodule Spender.Repo.Migrations.AddExpenseLogs do
  @moduledoc """
  This module holds the database schema for the expenselogs table
  we use this table to records events when an expenditure occurs
  """
  use Ecto.Migration

  @doc """
  This function creates a table with fields for a expense logs
  """
  def change do
    create table(:expenselogs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :budget_id, references(:budgets, on_delete: :nothing, type: :binary_id)
      add :desc, :string
      add :amount, :float
      add :expense_date, :date
    end
  end
end
