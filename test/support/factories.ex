defmodule Spender.Factories do
@moduledoc """
Ex Machina factories for application entities for testing
"""

# with Ecto
 use ExMachina.Ecto, repo: Spender.Repo

 def user_factory do
   %Spender.User{
     name: sequence(:name, &"user-#{&1}"),
     auth_token: sequence(:auth_token, &"token-#{&1}"),
     auth_provider: sequence(:auth_provider, &"provider-#{&1}")
   }
 end

{:ok, _} = Application.ensure_all_started(:ex_machina)
end
