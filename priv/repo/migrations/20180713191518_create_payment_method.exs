defmodule Spender.Repo.Migrations.CreatePaymentMethod do
  use Ecto.Migration
@moduledoc """
This module holds the database schema for the Payemet method table
"""
  def change do
    create table (:payment_methods)do
      add :name, :string
      add :balance, :float
      add :budget_id, references(:budgets)
    end
  end
end
