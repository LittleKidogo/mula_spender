defmodule Spender.Planning.MoneyGoal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Moneylog,
    Planning.MoneyGoal
  }

  @type t :: %__MODULE__{}

  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "moneygoals" do
    field :name, :string
    field :location, :string
    field :price, :float
    belongs_to :moneylog, Moneylog, foreign_key: :moneylog_id, type: :binary_id

    timestamps()
  end

  @spec changeset(MoneyGoal.t, map) :: Ecto.Changeset.t()
  def changeset(%MoneyGoal{} = moneygoal, attrs) do
    moneygoal
    |> cast(attrs, [:name, :location, :price])
    |> validate_required([:name, :price])
  end

  @spec create_changeset(Moneylog.t, map) :: Ecto.Changeset.t()
  def create_changeset(%Moneylog{} = moneylog, attrs) do
    %MoneyGoal{}
    |> changeset(attrs)
    |> put_assoc(:moneylog, moneylog)
  end

end
