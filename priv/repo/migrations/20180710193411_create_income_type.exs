defmodule Spender.Repo.Migrations.CreateIncomeType do
  use Ecto.Migration

  @moduledoc """
    This module hold the database schema for income type table
  """
  def change do
    create table(:income_types) do
      add(:name, :string)
      add(:balance, :float)
      add(:budget_id, references(:budgets))
    end
  end
end
