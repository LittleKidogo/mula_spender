defmodule Spender.MoneyLogs do
  @moduledoc """
  This is the MoneyLogs Context this is used to deal with
  CRUD actions for budgets
  """
  import Ecto.Query, warn: false
  alias Spender.Repo
  alias Spender.{Accounts, MoneyLogs.Owner, MoneyLogs.Budget}

  def list_budgets(owner) do
    Owner
    |> Repo.get(owner.id)
    |> Repo.preload(:budgets)
  end

  def create_budget(%Owner{} = owner, attrs \\ %{}) do
    %Budget{}
    |> Budget.changeset(attrs)
    |> Ecto.Changeset.put_change(:owner_id, owner.id)
    |> Repo.insert()
  end

 end

 def update_budget(%Budget{} = budget, attrs \\ %{}) do
   budget
   |> Budget.changeset(attrs)
   |> Repo.update()
 end
end
