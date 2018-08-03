defmodule Spender.MoneyLogs do
  @moduledoc """
  This is the MoneyLogs Context this is used to deal with
  CRUD actions for moneylogs
  """
  import Ecto.Query, warn: false
  alias Spender.Repo
  alias Spender.{ Accounts.User, MoneyLogs.Owner, MoneyLogs.Moneylog}


  @spec list_moneylog(Owner.t) :: {:ok, list(Moneylog.t)} | {:error, String.t}
  def list_moneylog(%{id: id} = _owner) do
    with [_|_] = moneylog <- Repo.all(Moneylog, [owner_id: id]) do
      {:ok, moneylog}
    else
      [] ->
        {:error, "user doesn't have any moneylogs"}
      end
  end

  @spec delete_moneylog(Moneylog.t):: {:ok, Moneylog.t} | {:error, Ecto.Changeset.t()}
  def delete_moneylog(%Moneylog{} = moneylog) do
    with {:ok, %Moneylog{} = moneylog} <- Repo.delete(moneylog) do
      {:ok, moneylog}
    end
  end

  def create_moneylog(%Owner{} = owner, attrs \\ %{}) do
    %Moneylog{}
    |> Moneylog.changeset(attrs)
    |> Ecto.Changeset.put_change(:owner_id, owner.id)
    |> Repo.insert()
  end

  def update_moneylog(%Moneylog{} = moneylog, attrs \\ %{}) do
   moneylog
   |> Moneylog.changeset(attrs)
   |> Repo.update()
  end

  @spec get_moneylog(integer()) :: Moneylog.t | {:error, String.t}
  def get_moneylog(id) do
    with %Moneylog{} = moneylog <- Moneylog |> Repo.get(id) do
      {:ok, moneylog}
    else
      nil ->
        {:error, "moneylog with id: #{id} not found"}
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
