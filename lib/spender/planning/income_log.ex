defmodule Spender.Planning.IncomeLog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.{
    Planning.IncomeLog,
    MoneyLogs.Budget
  }

  @type t :: %__MODULE__{}

  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "incomelogs" do
    field :amount, :float
    field :comments, :string
    field :earn_date, :date
    field :name, :string
    field :type, :string
    belongs_to :budget, Budget, foreign_key: :budget_id, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(%IncomeLog{} = income_log, attrs) do
    income_log
    |> cast(attrs, [:name, :comments, :type, :amount, :earn_date])
    |> validate_required([:name, :amount])
  end

  def create_changeset(%Budget{} = budget, attrs) do
    %IncomeLog{}
    |> IncomeLog.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:budget, budget)
  end
end
