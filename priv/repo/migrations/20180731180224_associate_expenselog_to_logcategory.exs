defmodule Spender.Repo.Migrations.AssociateExpenselogToLogcategory do
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
