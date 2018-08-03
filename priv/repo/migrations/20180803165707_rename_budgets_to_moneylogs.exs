defmodule Spender.Repo.Migrations.BugdetsToMoneylog do
  use Ecto.Migration

  @moduledoc """
  This migration Renames 'budgets' table to 'moneylog'
    Renames references in savingslogs, payment_methods, income_types, logcategories,
    expenselogs, moneygoals, incomelogs, logsections and wishlist_items tables to
    'moneylog'.
  """

  def change do
    rename table(:budgets), to: table(:moneylog)

    drop_if_exists index(:savings_log, [:money_log_id])
    drop_if_exists index(:payment_methods, [:budget_id])
    drop_if_exists index(:income_types, [:budget_id])
    drop_if_exists index(:logcategories, [:budget_id])
    drop_if_exists index(:expenselogs, [:budget_id])
    drop_if_exists index(:moneylog, [:budget_id])
    drop_if_exists index(:incomelogs, [:budget_id])
    drop_if_exists index(:logsections, [:budget_id])
    drop_if_exists index(:wishlist_items, [:budget_id])

    alter table(:savings_log) do
      remove :money_log_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:payment_methods) do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:income_types) do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:logcategories) do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:expenselogs) do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:moneygoals)do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:incomelogs)do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:logsections)do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    alter table(:wishlist_items)do
      remove :budget_id
      add :moneylog_id, references(:moneylog, on_delete: :nothing, type: :binary_id)
    end

    create index(:savings_log, [:moneylog_id])
    create index(:payment_methods, [:moneylog_id])
    create index(:income_types, [:moneylog_id])
    create index(:logcategories, [:moneylog_id])
    create index(:expenselogs, [:moneylog_id])
    create index(:incomelogs, [:moneylog_id])
    create index(:logsections, [:moneylog_id])
    create index(:wishlist_items, [:moneylog_id])
  end
end
