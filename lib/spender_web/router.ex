defmodule SpenderWeb.Router do
  @moduledoc """
  A module to map HTTP verb/path to controller/actions
  """
  use SpenderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpenderWeb do
    pipe_through :browser # Use the default browser stack
    get "/", WelcomeController, :index
    get "/hello/:messenger", WelcomeController, :show
    get "/showtext/:id", WelcomeController, :showtext
    get "/user/:id", WelcomeController, :showuser
    resources "/users", UserController, only: [:index, :show, :edit, :update]
  end

  # Other scopes may use custom stacks.
   scope "/api", SpenderWeb do
     pipe_through :api

     resources "/reviews", ReviewController
   end
end
