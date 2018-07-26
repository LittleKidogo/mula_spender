defmodule SpenderWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
    @desc "A system user"
    object :user do
      field :avatar, :string
      field :first_name, :string
      field :last_name, :string
      field :email, :string
      field :provider, :string
      field :token, :string
      field :id, :id
    end

    @desc "input for a user object"
    input_object :user_input do
      field :email, :string
      field :provider, :string
      field :token, :string
      field :id, :id
      field :avatar, :string
      field :first_name, :string
      field :last_name, :string
    end
end
