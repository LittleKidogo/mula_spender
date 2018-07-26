defmodule Spender.Repo.Migrations.CreateIncomeType do
  use Ecto.Migration

  @moduledoc """
    This module hold the database schema for income type table
  """
  def change do
    create table(:income_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:name, :string)
      add(:balance, :float)
      add(:budget_id, references(:budgets, on_delete: :nothing, type: :binary_id))
    end
  end
end
