defmodule Spender.Planning.LogSection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.Planning.LogSection


  schema "logsections" do
    field :duration, :float
    field :name, :string
    field :section_position, :integer

    timestamps()
  end

  @doc false
  def changeset(%LogSection{} = log_section, attrs) do
    log_section
    |> cast(attrs, [:name, :duration, :section_position])
    |> validate_required([:name, :duration, :section_position])
  end
end
