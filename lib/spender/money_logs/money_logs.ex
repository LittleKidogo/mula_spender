defmodule Spender.MoneyLogs do
  @moduledoc """
  This is the MoneyLogs Context this is used to deal with
  CRUD actions for budgets
  """
  import Ecto.Query, warn: false
  alias Spender.Repo
  alias Spender.{ Accounts.User, MoneyLogs.Owner, MoneyLogs.Budget}


  @spec list_budgets(Owner.t) :: {:ok, list(Budget.t)} | {:error, String.t}
  def list_budgets(%{id: id} = _owner) do
    with [_|_] = budgets <- Repo.all(Budget, [owner_id: id]) do
      {:ok, budgets}
    else
      [] ->
        {:error, "user doesn't have any moneylogs"}
      end
  end

  @spec delete_budget(Budget.t):: {:ok, Budget.t} | {:error, Ecto.Changeset.t()}
  def delete_budget(%Budget{} = budget) do
    with {:ok, %Budget{} = budget} <- Repo.delete(budget) do
      {:ok, budget}
    end
  end

  def create_budget(%Owner{} = owner, attrs \\ %{}) do
    %Budget{}
    |> Budget.changeset(attrs)
    |> Ecto.Changeset.put_change(:owner_id, owner.id)
    |> Repo.insert()
  end

  def update_budget(%Budget{} = budget, attrs \\ %{}) do
   budget
   |> Budget.changeset(attrs)
   |> Repo.update()
  end

  @spec get_budget(integer()) :: Budget.t | {:error, String.t}
  def get_budget(id) do
    with %Budget{} = budget <- Budget |> Repo.get(id) do
      {:ok, budget}
    else
      nil ->
        {:error, "budget with id: #{id} not found"}
    end
  end

  @spec create_owner(User.t, map) :: {:ok, Owner.t} | {:error, Ecto.Changeset.t()}
  def create_owner(%User{} = user, attrs) do
   user
   |> Owner.create_changeset(attrs)
   |> Repo.insert()
  end

  @spec get_owner(User.t) :: {:ok, Owner.t} |  {:error, nil}
  def get_owner(%{id: id} = _user) do
    with %Owner{} = owner <- Owner |> Repo.get_by([user_id: id]) do
      {:ok, owner}
    else
      nil ->
        {:error, "owner not found"}
    end
  end

  @spec fetch_or_create_owner(User.t) :: {:ok, Owner.t}
  def fetch_or_create_owner(user) do
    case get_owner(user) do
      {:ok, owner} -> {:ok, owner}
      {:error, _} -> create_owner(user, %{"name" => user.email})
    end
  end
end
