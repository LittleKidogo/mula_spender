defmodule Spender.Repo.Migrations.AddExpenseLogs do
  @moduledoc """
  This module holds the database schema for the expenselogs table
  we use this table to records events when an expentiture occurs
  """
  use Ecto.Migration

  @doc """
  This function creates a table with fields for a expense logs
  """
  def change do
    create table(:expenselogs) do
      add :name, :string
      add :budget_id, references(:budgets)
      add :desc, :string
      add :amount, :float
      add :expense_date, :date 
    end
  end
end
