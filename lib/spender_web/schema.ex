defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias SpenderWeb.Resolvers

  #import schema types
  import_types __MODULE__.UserTypes

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

  # add mutations handled by our schema
  mutation do
    field :update_user, :user do
      arg :input, non_null(:user_input)
      resolve &Resolvers.User.update_user/3
    end
  end
end
