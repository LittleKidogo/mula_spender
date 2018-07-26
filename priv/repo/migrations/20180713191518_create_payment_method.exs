defmodule Spender.Repo.Migrations.CreatePaymentMethod do
  @moduledoc """
  This module holds the database schema for the Payemet method table
  """
  use Ecto.Migration

  def change do
    create table(:payment_methods, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add(:name, :string)
      add(:balance, :float)
      add(:budget_id, references(:budgets, on_delete: :nothing, type: :binary_id))
    end
  end
end
