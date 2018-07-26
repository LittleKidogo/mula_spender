defmodule Spender.Repo.Migrations.AddOwnerIdToBudgets do
  use Ecto.Migration

  def change do
    alter table(:budgets) do
      add :owner_id, references(:owners, on_delete: :nothing, type: :binary_id),
                    null: false
    end

    create index(:budgets, [:owner_id])
  end
end
