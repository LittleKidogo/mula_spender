defmodule Spender.Planning.LogSection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.{
    Planning.LogSection,
    MoneyLogs.Budget
  }

  @type t :: %__MODULE__{}



  schema "logsections" do
    field :duration, :float
    field :name, :string
    field :section_position, :integer
    belongs_to :budget, Budget


    timestamps()
  end

  @doc false
  def changeset(%LogSection{} = log_section, attrs) do
    log_section
    |> cast(attrs, [:name, :duration, :section_position])
    |> validate_required([:name, :duration, :section_position])
  end

  def create_changeset(%Budget{} = budget, attrs) do
    %LogSection{}
    |> changeset(attrs)
    |> put_assoc(:budget, budget)
  end
end
