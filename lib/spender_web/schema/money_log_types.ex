defmodule SpenderWeb.Schema.MoneyLogTypes do
  use Absinthe.Schema.Notation

  @desc "An owner of a budget in the system"
  object :owner do
    field :name, :string
    field :id, :integer
    field :type, :string
    field :user_id, :integer
  end

  @desc "A Moneylog that belongs to a user"
  object :budget do
    field :id, non_null(:integer)
    field :owner_id, :integer
    field :amnt_in, :float
    field :amnt_out, :float
    field :end_date, :date
    field :is_active, :boolean
    field :name, :string
    field :refined, :boolean
    field :start_date, :date
  end

  @desc "Inputs for a MoneyLog"
  input_object :budget_input do
    field :name, non_null(:string)
    field :start_date, :date
    field :end_date, :date
  end

  @desc "Update object for a moneylog"
  input_object :budget_update do
    field :id, non_null(:integer)
    field :owner_id, :integer
    field :amnt_in, :float
    field :amnt_out, :float
    field :end_date, :date
    field :is_active, :boolean
    field :name, non_null(:string)
    field :refined, :boolean
    field :start_date, :date
  end
end
