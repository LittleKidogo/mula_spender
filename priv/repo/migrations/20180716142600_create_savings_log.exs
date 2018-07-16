defmodule Spender.Repo.Migrations.SavingsLog do
  @moduledoc """
  This module holds the database schema for the SavingsLog tables,
  """
  use Ecto.Migration

  def change do
    @doc """
    create a table with SavingsLog details
    """
    create table(:savingslog) do
      add :name, :string
      add :amount, :float
      add :log_category_id, references(:budgets)
      add :money_log_id, references(:budgets)

      timestamp()
    end
  end
end
