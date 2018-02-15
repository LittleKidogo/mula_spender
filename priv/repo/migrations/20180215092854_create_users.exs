defmodule Spender.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :auth_token, :string
      add :auth_provider, :string
      add :avatar, :string
    end
  end
end
