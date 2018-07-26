defmodule Spender.Repo.Migrations.CreateMoneyGoals do
  use Ecto.Migration

  def change do
    create table(:moneygoals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :location, :string
      add :price, :float
      add :budget_id, references(:budgets, on_delete: :nothing, type: :binary_id)
    end
  end
end
