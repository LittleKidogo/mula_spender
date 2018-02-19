defmodule Spender.User do
  @moduledoc """
  A Representation of the Spender.User Model

  """
  use Spender.Model

  schema "users" do
    field :name, :string
    field :auth_token, :string
    field :auth_provider, :string
    field :avatar, :string

    timestamps()
  end

  def create_changeset(user, params \\ %{}) do
    user
      |> cast(params, [:name, :auth_token, :auth_provider])
      |> validate_required([:name])
  end

  def update_user(user, params) do
    user
      |> create_changeset(params)
      |> cast(params, [:name, :id, :avatar, :auth_token, :auth_provider])
      |> validate_required([:name, :id, :avatar])
  end
end
