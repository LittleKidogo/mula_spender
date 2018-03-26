defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias Spender.{Accounts}
  alias SpenderWeb.{UserResolver}
  alias SpenderWeb.Schema.Middleware.ChangesetErrors


  # match on a mutation since we can get changset errors here
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ChangesetErrors]
  end
  def middleware(middleware, _field, _object) do
    middleware
  end


  @desc "A MoneyLog user"
  object :user do
    field :id, :id
    field :avatar, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :provider, :string
    field :token, :string
  end

  query do
    @desc "Get all users"
    field :all_users, list_of(:user) do
      resolve &UserResolver.all_users/3
    end

    @desc "Get user by email"
    field :user, :user do
      arg :email, non_null(:string)
      resolve &UserResolver.find_user/3
    end
  end

  mutation do
    field :create_user, :user do
      arg :provider, non_null(:string)
      arg :token, non_null(:string)
      arg :email, non_null(:string)

      resolve &UserResolver.create_user/3
    end
  end

end
