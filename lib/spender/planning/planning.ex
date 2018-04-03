defmodule Spender.Planning do
  @doc """
  Boundary module for  the Planning section to the,  This module should
  aid in the planning actions taken when a user is refining a MoneyLog
  """
  import Ecto.Query, warn: false

  alias Spender.{
    Repo,
    MoneyLogs.Budget,
    Planning.LogSection
  }

  @spec get_sections(Budget.t) ::  {:ok, list(LogSection.t)} | {:error, String.t()}
  def get_sections(%{id: id, name: name } = _budget) do
    query = from l in LogSection, where: l.budget_id == ^id

    with [_|_] = sections <- Repo.all(query) do
      {:ok, sections}
    else
      [] -> {:error, "#{name} doesn't have any sections"}
    end

  end

  @spec add_sections(Budget.t, integer()) :: {:ok, Budget.t} | {:error, String.t()}
  def add_sections(%Budget{} =  budget, num_sections) do
    with {:ok, budget} <- check_budget_dates(budget),
      {:ok, sectioned_budget} <- do_add_sections(budget, num_sections) do
        {:ok, sectioned_budget}
      end
  end

  @spec do_add_sections(Budget.t, integer()) :: {:ok, Budget.t}
  defp do_add_sections(%Budget{start_date: s_date, end_date: e_date} = budget, num_sections) do
    # get time diff between start date & end date
    spread = Date.diff(e_date, s_date)
    # get section duration by dividing time_diff by num_sections
    section_length = spread/num_sections

    sectioned_budget = do_save_section(budget, %{num: num_sections, length: section_length})

    {:ok, sectioned_budget}
  end

  @spec do_save_section(Budget.t , map) :: Budget.t
  defp do_save_section(%Budget{id: id} =  _budget, %{num: num, length: _length}) when num < 1 do
    Budget
    |> Repo.get(id)
    |> Repo.preload(:logsections)
  end

  @spec do_save_section(Budget.t, map) :: any()
  defp do_save_section(%Budget{} = budget, %{num: num, length: length} = details) do
    section_details = %{name: "Section #{num}", duration: length, section_position: num}

    budget
    |> LogSection.create_changeset(section_details)
    |> Repo.insert()

    do_save_section(budget, %{details | num: num - 1})
  end

  @spec check_budget_dates(Budget.t) :: {:ok, Budget.t} | {:error, String.t()}
  defp check_budget_dates(%Budget{} = budget) do
    cond do
      budget.start_date == nil ->
        {:error, "#{budget.name} needs a start date and an end date"}
      budget.end_date == nil ->
        {:error, "#{budget.name} needs a start date and an end date"}
      true ->
        {:ok, budget}
    end
  end


end
