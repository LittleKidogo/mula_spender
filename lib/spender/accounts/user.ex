defmodule Spender.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.Accounts.User
  alias Spender.MoneyLogs.Owner

  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "users" do
    field :avatar, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :provider, :string
    field :token, :string
    has_one :owner, Owner, on_delete: :nothing

    timestamps(inserted_at: :created_at, updated_at: false)
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:avatar, :first_name, :last_name, :email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
