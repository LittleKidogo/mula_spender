defmodule SpenderWeb.Resolvers.Planning do
  alias Spender.{
    MoneyLogs,
    MoneyLogs.Budget,
    Planning
  }

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
