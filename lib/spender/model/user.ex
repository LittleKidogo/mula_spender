defmodule Spender.User do
  @moduledoc """
  A Representation of the Spender.User Model
  """
  use Spender.Model

  alias Comeonin.Bcrypt

  schema "users" do
    field :name, :string
    field :auth_token, :string
    field :auth_provider, :string
    field :avatar, :string
    field :password, :string

    timestamps(inserted_at: :created_at, updated_at: :modified_at)

  end

  def create_changeset(user, params \\ %{}) do
    user
      |> cast(params, [:name, :auth_token, :auth_provider, :password])
      |> validate_required([:name])
      |> put_pass_hash()
      |> unique_constraint(:name)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset

  def update_changeset(user, params) do
    user
      |> create_changeset(params)
      |> cast(params, [:name, :id, :avatar, :auth_token, :auth_provider])
      |> validate_required([:name, :id, :avatar])
  end
end
