defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias SpenderWeb.Resolvers

  # build our queries
  query do
    field :users, list_of(:user) do
      resolve &Resolvers.User.users/3
    end

    field :user, :user do
      arg :id, :integer
      resolve &Resolvers.User.user/3
    end
  end

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
