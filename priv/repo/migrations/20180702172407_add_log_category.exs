defmodule Spender.Repo.Migrations.AddLogCategory do
  use Ecto.Migration
  @moduledoc """
  This module holds the database schema for the logCategory table.
  We use this table to records the logExpense when we log in an expense
  """

  @doc """
    This function creates a table with the logCategory details
  """
  def change do
    create table(:logcategories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :budget_id, references(:budgets, on_delete: :nothing, type: :binary_id)
    end
  end
end
