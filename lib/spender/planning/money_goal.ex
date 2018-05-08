defmodule Spender.Planning.MoneyGoal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Budget
  }

  @type t :: %__MODULE__{}

  schema "moneygoals" do
    field :name, :string
    field :location, :string
    field :price, :float
    belongs_to :budget, Budget

    timestamps()
  end

  
end
