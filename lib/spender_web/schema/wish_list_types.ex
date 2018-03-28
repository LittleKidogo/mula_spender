defmodule SpenderWeb.Schema.WishListTypes do
  use Absinthe.Schema.Notation

  @desc "A wishlist item"
  object :wish_list_item do
    field :location, :string
    field :name, :string
    field :price, :float
    field :qpm, :integer
    field :type, :string
    field :id, :integer
  end

  @desc "input object for wishlist items"
  input_object :wish_list_items_input do
    field :budget_id, non_null(:integer)
  end
end
