defmodule Spender.Planning.IncomeLog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.Planning.IncomeLog


  schema "incomelogs" do
    field :amount, :float
    field :comments, :string
    field :earn_date, :date
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%IncomeLog{} = income_log, attrs) do
    income_log
    |> cast(attrs, [:name, :comments, :type, :amount, :earn_date])
    |> validate_required([:name, :amount])
  end
end
