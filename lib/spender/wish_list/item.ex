defmodule Spender.WishList.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.{
    MoneyLogs.Budget,
    WishList.Item,
    Planning.LogSection
  }

  @type t :: %__MODULE__{}

  schema "wishlist_items" do
    field :location, :string
    field :name, :string
    field :price, :float
    field :qpm, :integer, default: 1
    field :type, :string
    belongs_to :budget, Budget
    belongs_to :log_section, LogSection

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:name, :type, :qpm, :price, :location])
    |> validate_required([:name, :price])
  end

  @spec create_changeset(Budget.t, map) :: Changeset.t
  def create_changeset(%Budget{} = budget, attrs) do
    %Item{}
    |> changeset(attrs)
    |> put_assoc(:budget, budget)
  end
end
