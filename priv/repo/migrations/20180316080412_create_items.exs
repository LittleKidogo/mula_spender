defmodule Spender.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :type, :string
      add :qpm, :integer
      add :price, :float
      add :location, :string

      timestamps()
    end

  end
end
