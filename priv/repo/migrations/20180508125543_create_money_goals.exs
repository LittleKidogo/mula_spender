defmodule Spender.Repo.Migrations.CreateMoneyGoals do
  use Ecto.Migration

  def change do
    create table(:moneygoals) do
      add :name, :string
      add :location, :string
      add :price, :float
      add :budget_id, references(:budgets)
    end
  end
end
