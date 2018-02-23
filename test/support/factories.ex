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
{:ok, _} = Application.ensure_all_started(:ex_machina)
end
