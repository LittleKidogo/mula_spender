defmodule SpenderWeb.Resolvers.Owner do
  alias Spender.{MoneyLogs, MoneyLogs.Owner}

  def get_owner(_, _, %{context: context}) do
    with {:ok, %Owner{} = owner} <- MoneyLogs.get_owner(context[:current_user]) do
      {:ok, owner}
    end
  end
end
