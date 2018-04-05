defmodule SpenderWeb.Schema.PlanningTypes do
  use Absinthe.Schema.Notation

  @desc "Input to add log sections to a MoneyLog"
  input_object :log_sections_input do
    field :budget_id, non_null(:integer)
    field :sections, non_null(:integer)
  end

  @desc "Input to fetch sections"
  input_object :get_sections_input do
    field :budget_id, non_null(:integer)
  end

  @desc "Input to update a logsection"
  input_object :log_section_update do
    field :id, non_null(:integer)
    field :duration, :float
    field :name, :string
    field :section_position, :integer
  end

  @desc "A Section in a MoneyLog"
  object :log_section do
    field :id, :integer
    field :duration, :float
    field :name, :string
    field :section_position, :integer
    field :budget_id, :integer
  end
end
