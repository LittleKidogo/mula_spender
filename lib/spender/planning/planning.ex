defmodule Spender.Planning do
  @doc """
  Boundary module for  the Planning section to the,  This module should
  aid in the planning actions taken when a user is refining a MoneyLog
  """
  import Ecto.Query, warn: false

  alias Spender.{
    Repo,
    MoneyLogs,
    MoneyLogs.Budget,
    Planning.LogSection,
    Planning.IncomeLog,
    WishList.Item
  }

  @spec add_item_to_section(Item.t, LogSection.t) :: {:ok, LogSection.t} | {:error, Ecto.Changeset.t()}
  def add_item_to_section(%Item{} = item, %LogSection{} = logsection) do
    item = item |> Repo.preload(:log_sections)

    with {:ok, %Item{} = updated_item} <- Item.add_to_section(item, logsection) |> Repo.update(),
        %Item{} = loaded_item <- Repo.preload(updated_item, :budget),
        {:ok, _budget} <- update_budget_status(loaded_item.budget),
      %LogSection{} = loaded_section <- logsection |> Repo.preload(:wishlist_items)  do
        {:ok, loaded_section}
      end
  end

  @spec get_income(integer()) :: {:ok, IncomeLog.t} | {:error, String.t()}
  def get_income(id) do
    with %IncomeLog{} = log <- IncomeLog |> Repo.get(id) do
      {:ok, log}
    else
      nil -> {:error, "Income doesn't exist"}
    end
  end

  @spec update_section(LogSection.t, map) :: {:ok, LogSection.t} | {:error, Ecto.Changeset.t()}
  def update_section(%LogSection{} = logsection, attrs) do
    logsection
    |> LogSection.changeset(attrs)
    |> Repo.update()
  end

  @spec add_income(Budget.t, map) :: {:ok, IncomeLog.t} | {:error, Ecto.Changeset.t()}
  def add_income(%Budget{} = budget, attrs) do
    budget
    |> IncomeLog.create_changeset(attrs)
    |> Repo.insert()
  end

  @spec update_income(IncomeLog.t, map) :: {:ok, IncomeLog.t} | {:error, Ecto.Changeset.t()}
  def update_income(%IncomeLog{} = incomelog, attrs) do
    incomelog
    |> IncomeLog.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_income(IncomeLog.t) :: {:ok, IncomeLog.t} | {:error, Ecto.Changeset.t()}
  def delete_income(%IncomeLog{} = income) do
    income |> Repo.delete()
  end

  @spec get_section(integer()) :: {:ok, LogSection.t} | {:error, String.t()}
  def get_section(id) do
    with %LogSection{} = logsection <- Repo.get(LogSection, id) do
      {:ok, logsection}
    else
      nil -> {:error, "Section doesn't exist"}
    end
  end

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

  @spec update_budget_status(Budget.t) :: {:ok, Budget.t}
  defp update_budget_status(%Budget{status: status} = budget) do
    case status do
      "planning" ->
        {:ok, updated_budget} = budget |> MoneyLogs.update_budget(%{status: "refined"})
        {:ok, updated_budget}
        _ ->
        {:ok, budget}
    end
  end
end
