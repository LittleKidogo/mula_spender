defmodule Spender.Repo.Migrations.CreateSavingsLog do
  @moduledoc """
  This module holds the database schema for the SavingsLog tables,
  """
  use Ecto.Migration

  @doc """
  create a table with SavingsLog details
  """
  def change do
    create table(:savings_log) do
      add(:name, :string)
      add(:amount, :float)
      add(:log_category_id, references(:log_categories))
      add(:money_log_id, references(:budgets))
    end
  end
end
