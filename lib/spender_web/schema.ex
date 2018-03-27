defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias SpenderWeb.Resolvers
  alias SpenderWeb.Schema.Middleware

  #import schema types
  import_types __MODULE__.UserTypes
  import_types __MODULE__.MoneyLogTypes

  # build our queries
  query do
    field :users, list_of(:user) do
      resolve &Resolvers.User.users/3
    end

    field :user, :user do
      arg :id, :integer
      resolve &Resolvers.User.user/3
    end

    field :owner, :owner do
      arg :user_id, :integer
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.get_owner/3
    end
  end

  # add mutations handled by our schema
  mutation do
    field :update_user, :user do
      arg :input, non_null(:user_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.User.update_user/3
    end
  end
end
