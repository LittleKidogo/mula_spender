defmodule SpenderWeb.Schema.MoneyLogTypes do
  use Absinthe.Schema.Notation

  @desc "An owner of a budget in the system"
  object :owner do
    field :name, :string
    field :id, :integer
    field :type, :string
    field :user_id, :integer
  end
end
