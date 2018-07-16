defmodule Spender.Repo.Migrations.CreateSavingsLog do
  @moduledoc """
  This module holds the database schema for the SavingsLog tables,
  """
  use Ecto.Migration
  @doc """
    create a table with SavingsLog details
    """
  def change do
    create table(:savingslog) do
      add :name, :string
      add :amount, :float
      add :log_category_id, references(:logcategories)
      add :money_log_id, references(:budgets)

      timestamp()
    end
  end
end
