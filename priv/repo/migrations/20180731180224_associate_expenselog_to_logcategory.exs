defmodule Spender.Repo.Migrations.AssociateExpenselogToLogcategory do
  @moduledoc """
  This module alters the database schema for the expenselog table to include the
  logcategory_id

  """
  use Ecto.Migration

  def change do
    alter table(:expenselogs) do
      add(
        :logcategory_id,
        references(:logcategories, on_delete: :nothing, type: :binary_id),
        null: false
      )
    end

    create(index(:expenselogs, [:logcategory_id]))
  end
end
