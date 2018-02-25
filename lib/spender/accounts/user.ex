defmodule Spender.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.Accounts.User


  schema "users" do
    field :avatar, :string
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps(inserted_at: :created_at, updated_at: false)
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:avatar, :firstname, :lastname, :email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
