defmodule Spender.Repo.Migrations.AssociateLogIncomeToBudget do
  use Ecto.Migration

  def change do
    alter table(:incomelogs) do
      add :budget_id, references(:budgets, on_delete: :delete_all, type: :binary_id),
                        null: false
    end

    create index(:incomelogs, [:budget_id])
  end
end
