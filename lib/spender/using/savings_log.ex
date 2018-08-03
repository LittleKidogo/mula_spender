defmodule Spender.Using.SavingsLog do
  @moduledoc """
  This module defines the layout and functions of the SavingsLog
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Moneylog,
    Planning.LogCategory
  }
  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "savings_log" do
    field(:name, :string)
    field(:amount, :float)
    belongs_to(:logcategory, LogCategory, foreign_key: :log_category_id, type: :binary_id)
    belongs_to(:moneylog, Moneylog, foreign_key: :moneylog_id, type: :binary_id)
  end

  @doc """
  This changeset function takes in a struct and map containing parameters
  It proceeds to match the parameters in the the map the schema above
  """
  @spec changeset(SavingsLog.t(), map) :: Changeset.t()
  def changeset(savings_log, attrs \\ %{}) do
    savings_log
    |> cast(attrs, [:name, :amount])
    |> validate_required([:name, :amount])
  end
end
