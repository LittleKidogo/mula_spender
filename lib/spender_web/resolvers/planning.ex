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
end
