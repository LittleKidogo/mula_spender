defmodule Spender.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :type, :string
      add :qpm, :integer
      add :price, :float
      add :location, :string

      timestamps()
    end

  end
end
