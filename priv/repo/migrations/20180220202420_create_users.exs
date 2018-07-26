defmodule Spender.Repo.Migrations.CreateUsers do
  use Ecto.Migration


  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :avatar, :string
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps(inserted_at: :created_at, updated_at: false)
    end

  end
end
