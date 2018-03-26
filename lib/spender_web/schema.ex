defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  # build our queries
  query do
    field :users, list_of(:user) do
      resolve fn _,_,_ ->
        {:ok, Spender.Repo.all(Spender.Accounts.User)}
      end
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
