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
    create table (:log_categories) do
      add :name, :string
      add :budget_id, references(:budgets)
    end
  end
end
