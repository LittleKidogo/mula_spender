defmodule Spender.Factories do
@moduledoc """
Ex Machina factories for application entities for testing
"""

# with Ecto
 use ExMachina.Ecto, repo: Spender.Repo

# User Factory
def user_factory do
  %Spender.Accounts.User{
    email: sequence(:email, &"user-#{&1}-email.com"),
    token: sequence(:token, &"user-#{&1}-token"),
    provider: sequence(:provider, &"user-#{&1}-provider")
  }
end

# Budget Factory
def budget_factory do
%Spender.MoneyLogs.Budget {
  name: sequence(:name, &"budget-#{&1}"),
  start_date: Date.utc_today,
  end_date: Date.add(Date.utc_today, 5),
  owner: build(:owner)
}
end
# Owner Factory
def owner_factory do
  %Spender.MoneyLogs.Owner {
    name: sequence(:name, &"owner-#{&1}"),
    user: build(:user)
  }
end

def wishlist_item_factory do
  %Spender.WishList.Item {
    name: sequence(:name, &"item-#{&1}"),
    owner: build(:owner)
    budget: build(:budget)
  }
end
{:ok, _} = Application.ensure_all_started(:ex_machina)
end
