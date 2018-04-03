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
end
