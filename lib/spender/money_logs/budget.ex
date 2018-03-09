defmodule Spender.MoneyLogs.Budget do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.MoneyLogs.{Owner}


  schema "budgets" do
    field :amnt_in, :float
    field :amnt_out, :float
    field :end_date, :date
    field :is_active, :boolean, default: false
    field :name, :string
    field :refined, :boolean, default: false
    field :start_date, :date
    # "new" "planning" "refined" "active" "expired"
    field :status, :string, default: "new"
    belongs_to :owner, Owner

    timestamps(inserted_at: :created_at, updated_at: :modified_at)
  end

  @doc false
  def changeset(%Budget{} = budget, attrs) do
    budget
    |> cast(attrs, [:name, :refined, :amnt_in, :amnt_out, :is_active, :start_date, :end_date, :status])
    |> validate_required([:name, :start_date, :end_date])
  end

  def update_status(budget, attrs) do
    budget
    |> changeset(attrs)
    |> cast(attrs, [:status])
    |> validate_inclusion(:status, ["new","planning","refined","active","expired"])
  end
end
