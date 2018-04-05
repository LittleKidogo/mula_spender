defmodule Spender.Repo.Migrations.CreateLogsections do
  use Ecto.Migration

  def change do
    create table(:logsections) do
      add :name, :string
      add :duration, :float
      add :section_position, :integer

      timestamps()
    end

  end
end
