defmodule Spender.Repo.Migrations.CreateSavingsLog do
  @moduledoc """
  This module holds the database schema for the SavingsLog tables,
  """
  use Ecto.Migration

  @doc """
  create a table with SavingsLog details
  """
  def change do
    create table(:savings_log, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:name, :string)
      add(:amount, :float)
      add(:log_category_id, references(:logcategories, on_delete: :nothing, type: :binary_id))
      add(:money_log_id, references(:budgets, on_delete: :nothing, type: :binary_id))
    end
  end
end
