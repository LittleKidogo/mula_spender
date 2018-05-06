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
    many_to_many :log_sections, LogSection, join_through: "logsections_items", join_keys: [wishlist_item_id: :id, log_section_id: :id]
    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:name, :type, :qpm, :price, :location])
    |> validate_required([:name, :price])
  end

  @spec create_changeset(Budget.t, map) :: Ecto.Changeset.t()
  def create_changeset(%Budget{} = budget, attrs) do
    %Item{}
    |> changeset(attrs)
    |> put_assoc(:budget, budget)
  end

  @spec add_to_section(Item.t, LogSection.t) :: Ecto.Changeset.t()
  def add_to_section(%Item{qpm: qpm, log_sections: sections} = item, %LogSection{} = section) do
    item
    |> change(%{})
    |> put_assoc(:log_sections, sections ++ [section])
    |> validate_length(:log_sections, max: qpm)
  end
end
