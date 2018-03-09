defmodule Spender.Repo.Migrations.CreateOwners do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :name, :string
      add :type, :string
      add :user_id, references(:users, on_delete: :delete_all),
                    null: false

      timestamps(inserted_at: :created_at, updated_at: :modified_at)
    end

    create unique_index(:owners, [:user_id])
  end
end
