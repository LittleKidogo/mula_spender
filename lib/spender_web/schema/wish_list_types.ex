defmodule SpenderWeb.Schema.WishListTypes do
  use Absinthe.Schema.Notation

  @desc "A wishlist item"
  object :wish_list_item do
    field :location, :string
    field :name, :string
    field :price, :float
    field :qpm, :integer
    field :type, :string
    field :id, :id
  end

  @desc "input object for wishlist items"
  input_object :wish_list_items_input do
    field :moneylog_id, non_null(:id)
  end

  @desc "inputs object to create a wishlist item"
  input_object :wish_list_item_input do
    field :moneylog_id, non_null(:id)
    field :location, :string
    field :name, non_null(:string)
    field :price, non_null(:float)
    field :qpm, :integer
    field :type, :string
  end

  @desc "input object for updating an wishlist item"
  input_object :wish_list_item_update_input do
    field :location, :string
    field :name, :string
    field :price, :float
    field :qpm, :integer
    field :type, :string
    field :id, non_null(:id)
  end
end
