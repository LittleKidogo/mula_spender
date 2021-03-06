defmodule Spender.Using.PaymentMethod do
  @moduledoc """
    This module holds the schema and changeset functions fot the payment_method
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Spender.{
    MoneyLogs.Moneylog,
    Using.PaymentMethod
  }

  @type t :: %__MODULE__{}

    #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "payment_methods" do
    field(:name, :string)
    field(:balance, :float)
    belongs_to(:moneylog, Moneylog, foreign_key: :moneylog_id, type: :binary_id)
  end

  @doc """
  This changeset function takes in a struct and map containing parameters
  It proceeds to match the parameters in the schema above
  """
  @spec changeset(PaymentMethod.t(), map()) :: Ecto.Changeset.t()
  def changeset(paymentmethod, attrs \\ %{}) do
    paymentmethod
    |> cast(attrs, [:name, :balance])
    |> validate_required([:name, :balance])
    |> validate_length(:name, max: 40)
  end

  @doc """
    This function takes in a struct and a map containing parameters,
    It proceeds to match the parameters in the schema above
  """
  @spec create_changeset(Moneylog.t(), map()) :: Ecto.Changeset.t()
  def create_changeset(%Moneylog{} = moneylog, attrs) do
    %PaymentMethod{}
    |> PaymentMethod.changeset(attrs)
    |> put_assoc(:moneylog, moneylog)
  end
end
