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

# Add a scope for authorization
  scope "/auth", SpenderWeb do
    pipe_through [:browser]

    get "/:provider", AuthController, :request

    get "/:provider/callback", AuthController, :new
  end

  scope "/", SpenderWeb do
    pipe_through [:browser]

    get "/", AuthController, :welcome
  end

  scope "/api", SpenderWeb do
    pipe_through :api # Use the default browser stack
    resources "/users", UserController, except: [:new, :edit]
  end

  # scope "/", SpenderWeb do
  #   get "/redirect_test", WelcomeController, :redirect_test, as: :redirect_test
  # end
end
