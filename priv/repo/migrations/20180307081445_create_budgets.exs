defmodule Spender.Repo.Migrations.CreateBudgets do
  use Ecto.Migration

  def change do
    create table(:budgets) do
      add :name, :string
      add :refined, :boolean, default: false, null: false
      add :amnt_in, :float
      add :amnt_out, :float
      add :is_active, :boolean, default: false, null: false
      add :start_date, :date
      add :end_date, :date
      add :status, :string

      timestamps(inserted_at: :created_at, updated_at: :modified_at)
    end

  end
end
