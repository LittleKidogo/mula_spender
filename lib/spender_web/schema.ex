defmodule SpenderWeb.Schema do
  use Absinthe.Schema

  alias SpenderWeb.Resolvers
  alias SpenderWeb.Schema.Middleware

  #middleware
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  #import schema types
  import_types Absinthe.Type.Custom
  import_types __MODULE__.UserTypes
  import_types __MODULE__.MoneyLogTypes
  import_types __MODULE__.WishListTypes
  import_types __MODULE__.PlanningTypes



  # build our queries
  query do
    @desc "Gets all LogSections in MoneyLog"
    field :sections, list_of(:log_section) do
      arg :input, non_null(:get_sections_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.get_sections/3
    end

    @desc "Gets all Wishlist Items in a budget"
    field :wish_list_items, list_of(:wish_list_item) do
      arg :input, non_null(:wish_list_items_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.WishList.get_items/3
    end

    @desc "Lists all budgets for a user"
    field :budgets, list_of(:budget) do
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.get_budgets/3
    end

    @desc "Lists all users on the system"
    field :users, list_of(:user) do
      resolve &Resolvers.User.users/3
    end

    @desc "Gets a single user who"
    field :user, :user do
      arg :id, :id
      resolve &Resolvers.User.user/3
    end

    @desc "Gets the owner profile of the logged in user"
    field :owner, :owner do
      arg :user_id, :id
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.get_owner/3
    end
  end

  # add mutations handled by our schema
  mutation do
    @desc "Links an item to a LogSection"
    field :link_item, :log_section do
      arg :input, non_null(:link_item_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.link_item/3
    end

    @desc "Unlinks an item from a LogSection"
    field :unlink_item, :log_section do
      arg :input, non_null(:link_item_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.unlink_item/3
    end

    @desc "Deletes an income from a MoneyLog"
    field :delete_income_log, :income_log do
      arg :input, non_null(:income_log_update_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.delete_income/3
    end

    @desc "Logs an income in a MoneyLog"
    field :add_income_log, :income_log do
      arg :input, non_null(:income_log_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.add_income/3
    end

    @desc "Updates an income in a MoneyLog"
    field :update_income_log, :income_log do
      arg :input, non_null(:income_log_update_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.update_income/3
    end

    @desc "Deletes an exisiting MoneyLog"
    field :delete_budget, :budget do
      arg :input, non_null(:budget_update)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.delete_budget/3
    end

    @desc "Deletes a WishList Item"
    field :delete_wish_list_item, :wish_list_item do
      arg :input, non_null(:wish_list_item_update_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.WishList.delete_item/3
    end

    @desc "Update a LogSection"
    field :update_log_section, :log_section do
      arg :input, non_null(:log_section_update)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.update_section/3
    end

    @desc "Add sections to a MoneyLog"
    field :add_log_sections, :budget do
      arg :input, non_null(:log_sections_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Planning.add_sections/3
    end

    @desc "Updates a WishList Item"
    field :update_wish_list_item, :wish_list_item do
      arg :input, non_null(:wish_list_item_update_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.WishList.update_item/3
    end

    @desc "creates a wishlist item"
    field :create_wish_list_item, :wish_list_item do
      arg :input, non_null(:wish_list_item_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.WishList.create_item/3
    end

    @desc "Updates a given user"
    field :update_user, :user do
      arg :input, non_null(:user_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.User.update_user/3
    end

    @desc "Creates a budget for an owner"
    field :create_budget, :budget  do
      arg :input, non_null(:budget_input)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.create_budget/3
    end

    @desc "Updates a given budget"
    field :update_budget, :budget do
      arg :input, non_null(:budget_update)
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Owner.update_budget/3
    end
  end
end
