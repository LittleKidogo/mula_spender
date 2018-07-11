defmodule SpenderWeb.Resolvers.Planning do
  @moduledoc """
  This module holds functions we use to resolve objects that we get from the
  Planning context.
  add resolver function to link a WishListItem to a LogSection
  """
  alias Spender.{
    MoneyLogs,
    MoneyLogs.Budget,
    Planning,
    Planning.LogSection,
    WishList,
    WishList.Item
  }

  @doc """
  This function take in its input params a LogSection id and  a
  WishListItem id. It links this two together and returns the
  LogSection preloaded with wishlist items
  """
  @spec link_item(any(), map(), any()) :: {:ok, LogSection.t()} | {:error, String.t()}
  def link_item(_,%{input: params}, _) do
    with {:ok, %Item{} = item} <- WishList.get_item(params.item_id),
      {:ok, %LogSection{} = section} <- Planning.get_section(params.section_id),
      {:ok, %LogSection{} = loaded_section} <- Planning.add_item_to_section(item, section) do
        {:ok, loaded_section}
      end
  end

  @doc """
  This function takes  the same input as the link_item input only it does an inverse of
  what link_item does i.e it removes the provided item from the provided section
  """
  @spec unlink_item(any(), map(), any()) :: {:ok, LogSection.t()} | {:error, String.t()}
  def unlink_item(_, %{input: params}, _) do
    with {:ok, %Item{} = item} <- WishList.get_item(params.item_id),
      {:ok, %LogSection{} = section} <- Planning.get_section(params.section_id),
      {:ok, %LogSection{} = cleared_section} <- Planning.remove_item_from_section(item, section) do
        {:ok, cleared_section}
      end
  end

  @doc """
  This function resolves all LogSections in a MoneyLog as a list
  add resolver function to link a WishListItem to a LogSection
  """
  @spec get_sections(any(), map(), any()) :: {:ok, list(LogSection.t())} | {:error, String.t()}
  def get_sections(_,%{input: params}, _) do
    with {:ok, budget} <- MoneyLogs.get_budget(params.budget_id),
      {:ok, sections} <- Planning.get_sections(budget) do
        {:ok, sections}
      end
  end

  def add_sections(_,%{input: params}, _) do
    with {:ok, budget} <- MoneyLogs.get_budget(params.budget_id),
    {:ok, sectioned_budget} <- Planning.add_sections(budget, params.sections) do
      {:ok, sectioned_budget}
    end
  end

  def update_section(_, %{input: params}, _) do
    with {:ok, section} <- Planning.get_section(params.id),
    {:ok, updated_section} <- Planning.update_section(section, params) do
      {:ok, updated_section}
    end
  end

  def add_income(_, %{input: params}, _) do
    with {:ok, budget} <- MoneyLogs.get_budget(params.budget_id),
      {:ok, incomelog} <- Planning.add_income(budget, params) do
        {:ok, incomelog}
      end
  end

  def update_income(_, %{input: params}, _) do
    with {:ok, income} <- Planning.get_income(params.id),
      {:ok, updated_income} <- Planning.update_income(income, params) do
        {:ok, updated_income}
      end
  end

  def delete_income(_, %{input: params}, _) do
    with {:ok, income} <- Planning.get_income(params.id),
      {:ok, deleted_income} <- Planning.delete_income(income) do
        {:ok, deleted_income}
      end
  end
end
