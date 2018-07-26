defmodule Spender.Repo.Migrations.CreateLogsections do
  use Ecto.Migration

  def change do
    create table(:logsections, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :duration, :float
      add :section_position, :integer

      timestamps()
    end

  end
end
