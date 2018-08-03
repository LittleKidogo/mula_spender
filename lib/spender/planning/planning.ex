defmodule Spender.Planning do
  @moduledoc """
  Boundary module for  the Planning section to the,  This module should
  aid in the planning actions taken when a user is refining a MoneyLog
  """
  import Ecto.Query, warn: false

  alias Spender.{
    Repo,
    MoneyLogs,
    MoneyLogs.Moneylog,
    Planning.LogSection,
    Planning.IncomeLog,
    WishList.Item
  }

  @doc """
  This function allows us to link add an Item into a LogSection in the MoneyLog
  It accepts an Item and a LogSection
  It creates an association between them and returns the LogSection Preloaded with
  Items
  """
  @spec add_item_to_section(Item.t, LogSection.t) :: {:ok, LogSection.t} | {:error, Ecto.Changeset.t()}
  def add_item_to_section(%Item{} = item, %LogSection{} = logsection) do
    item = item |> Repo.preload(:log_sections)

    with {:ok, %Item{} = updated_item} <- Item.add_to_section(item, logsection) |> Repo.update(),
        %Item{} = loaded_item <- Repo.preload(updated_item, :moneylog),
        {:ok, _moneylog} <- update_moneylog_status(loaded_item.moneylog),
      %LogSection{} = loaded_section <- logsection |> Repo.preload(:wishlist_items)  do
        {:ok, loaded_section}
      end
  end

  @doc """
  This function allows us to delete the link between an Item and a LogSection
  It accespts an Item and LogSection, deletes the association and returns a section
  with the item removed
  """
  def remove_item_from_section(%Item{} = item, %LogSection{} = logsection) do
    plain_item = Repo.get_by(Item, id: item.id)
    loaded_item = item |> Repo.preload(:log_sections)
    loaded_section = logsection |> Repo.preload(:wishlist_items)

    with {:ok, %Item{}} <- Item.remove_from_section(loaded_item, logsection) |> Repo.update(),
        {:ok, cleared_section}  <- LogSection.remove_item(loaded_section, plain_item) |> Repo.update(),
        %LogSection{} = updated_section <- cleared_section |> Repo.preload(:wishlist_items)  do
          {:ok, updated_section}
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

  @spec add_income(Moneylog.t, map) :: {:ok, IncomeLog.t} | {:error, Ecto.Changeset.t()}
  def add_income(%Moneylog{} = moneylog, attrs) do
    moneylog
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

  @spec get_sections(Moneylog.t) ::  {:ok, list(LogSection.t)} | {:error, String.t()}
  def get_sections(%{id: id, name: name } = _moneylog) do
    query = from l in LogSection, where: l.moneylog_id == ^id

    with [_|_] = sections <- Repo.all(query) do
      {:ok, sections}
    else
      [] -> {:error, "#{name} doesn't have any sections"}
    end

  end

  @spec add_sections(Moneylog.t, integer()) :: {:ok, Moneylog.t} | {:error, String.t()}
  def add_sections(%Moneylog{} =  moneylog, num_sections) do
    with {:ok, moneylog} <- check_moneylog_dates(moneylog),
      {:ok, sectioned_moneylog} <- do_add_sections(moneylog, num_sections) do
        {:ok, sectioned_moneylog}
      end
  end

  @spec do_add_sections(Moneylog.t, integer()) :: {:ok, Moneylog.t}
  defp do_add_sections(%Moneylog{start_date: s_date, end_date: e_date} = moneylog, num_sections) do
    # get time diff between start date & end date
    spread = Date.diff(e_date, s_date)
    # get section duration by dividing time_diff by num_sections
    section_length = spread/num_sections

    sectioned_moneylog = do_save_section(moneylog, %{num: num_sections, length: section_length})

    {:ok, sectioned_moneylog}
  end

  @spec do_save_section(Moneylog.t , map) :: Moneylog.t
  defp do_save_section(%Moneylog{id: id} =  _moneylog, %{num: num, length: _length}) when num < 1 do
    Moneylog
    |> Repo.get(id)
    |> Repo.preload(:logsections)
  end

  @spec do_save_section(Moneylog.t, map) :: any()
  defp do_save_section(%Moneylog{} = moneylog, %{num: num, length: length} = details) do
    section_details = %{name: "Section #{num}", duration: length, section_position: num}

    moneylog
    |> LogSection.create_changeset(section_details)
    |> Repo.insert()

    do_save_section(moneylog, %{details | num: num - 1})
  end

  @spec check_moneylog_dates(Moneylog.t) :: {:ok, Moneylog.t} | {:error, String.t()}
  defp check_moneylog_dates(%Moneylog{} = moneylog) do
    cond do
      moneylog.start_date == nil ->
        {:error, "#{moneylog.name} needs a start date and an end date"}
      moneylog.end_date == nil ->
        {:error, "#{moneylog.name} needs a start date and an end date"}
      true ->
        {:ok, moneylog}
    end
  end

  @spec update_moneylog_status(Moneylog.t) :: {:ok, Moneylog.t}
  defp update_moneylog_status(%Moneylog{status: status} = moneylog) do
    case status do
      "planning" ->
        {:ok, updated_moneylog} = moneylog |> MoneyLogs.update_moneylog(%{status: "refined"})
        {:ok, updated_moneylog}
        _ ->
        {:ok, moneylog}
    end
  end
end
