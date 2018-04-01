defmodule Spender.PlanningTest do
  use Spender.DataCase

  alias Spender.{
    Planning,
    Planning.LogSection
  }

  @num_sections 5
  describe "Planning Boundary" do

    test "it should return an error if start_date and end_date are not set for a budget" do
      no_date_attrs = %{name: "Food Lovers", start_date: nil, end_date: nil}
      budget = insert(:budget, no_date_attrs)

     {:error, message} = Planning.add_sections(budget, @num_sections)

     assert message == "#{budget.name} needs a start date and an end date"
    end

    test "it should return a budget preloaded with sections" do
      budget = insert(:budget)
      assert Repo.aggregate(LogSection, :count, :id) == 0
      {:ok, budget} = Planning.add_sections(budget, @num_sections)
      assert Repo.aggregate(LogSection, :count, :id) == @num_sections
      assert Enum.count(budget.logsections) == @num_sections
    end
  end
end
