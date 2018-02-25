defmodule Spender.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :avatar, :string
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps(inserted_at: :created_at, updated_at: false)
    end

  end
end
