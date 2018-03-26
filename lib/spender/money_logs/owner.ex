defmodule Spender.MoneyLogs.Owner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Spender.{MoneyLogs.Owner, MoneyLogs.Budget, Accounts.User}

  @type t :: %__MODULE__{}



  schema "owners" do
    field :name, :string
    field :type, :string
    has_many :budgets, Budget
    belongs_to :user, User

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
