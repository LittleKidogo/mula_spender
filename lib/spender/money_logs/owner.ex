defmodule Spender.MoneyLogs.Owner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.MoneyLogs.Owner


  schema "owners" do
    field :name, :string
    field :type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Owner{} = owner, attrs) do
    owner
    |> cast(attrs, [:name, :type])
    |> validate_required([:name])
    |> unique_constraint(:user_id)
  end
end
