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
    end
end
