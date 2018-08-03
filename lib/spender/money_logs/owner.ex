defmodule Spender.MoneyLogs.Owner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.{MoneyLogs.Owner, MoneyLogs.Moneylog, Accounts.User}

  @type t :: %__MODULE__{}

  #binary key setup
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}


  schema "owners" do
    field :name, :string
    field :type, :string
    has_many :moneylogs, Moneylog, on_delete: :delete_all
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id # this needs a type

    timestamps(inserted_at: :created_at, updated_at: :modified_at)
  end

  @doc false
  def changeset(%Owner{} = owner, attrs) do
    owner
    |> cast(attrs, [:name, :type])
    |> validate_required([:name])
    |> unique_constraint(:user_id)
  end

  @spec create_changeset(User.t, map) :: {:ok, Owner.t} | {:error, Ecto.Changeset.t()}
  def create_changeset(%User{} = user, attrs) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
  end
end
