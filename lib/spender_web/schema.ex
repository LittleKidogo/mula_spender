defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias SpenderWeb.Resolvers
  alias SpenderWeb.Schema.Middleware

  #middleware
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  #import schema types
  import_types Absinthe.Type.Custom
  import_types __MODULE__.UserTypes
  import_types __MODULE__.MoneyLogTypes



  # build our queries
  query do
    field :budgets, list_of(:budget) do
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.get_budgets/3
    end

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

    field :create_budget, :budget  do
      arg :input, non_null(:budget_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.create_budget/3
    end
  end
end
