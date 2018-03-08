defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias Spender.{Accounts}
  alias SpenderWeb.UserResolver

  object :user do
    field :avatar, non_null(:string)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :email, non_null(:string)
    field :provider, non_null(:string)
    field :token, non_null(:string)
  end

  query do
    field :all_users, non_null(list_of(non_null(:user))) do
      resolve &UserResolver.all_users/3
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
