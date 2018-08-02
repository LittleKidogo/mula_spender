defmodule Spender.Repo.Migrations.AssociateExpenselogToPaymentmethod do
  @moduledoc """
  This module alters the database schema for the expenselogd table
  """
  use Ecto.Migration

  def change do
    alter table(:expenselogs) do
      add(
        :paymentmethod_id,
        references(:payment_methods, on_delete: :nothing, type: :binary_id),
        null: false
      )
    end

    create(index(:expenselogs, [:paymentmethod_id]))
  end
end
