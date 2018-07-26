defmodule Spender.Repo.Migrations.CreateIncomelogs do
  use Ecto.Migration

  def change do
    create table(:incomelogs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :comments, :text
      add :type, :string
      add :amount, :float
      add :earn_date, :date

      timestamps()
    end

  end
end
