defmodule Spender.Repo.Migrations.CreateOwners do
  use Ecto.Migration

  def change do
    create table(:owners, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :type, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id),
                    null: false

      timestamps(inserted_at: :created_at, updated_at: :modified_at)
    end

    create unique_index(:owners, [:id])
  end
end
