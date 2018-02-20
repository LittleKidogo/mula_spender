defmodule SpenderWeb.Router do
  @moduledoc """
  A module to map HTTP verb/path to controller/actions
  """
  use SpenderWeb, :router

  pipeline :auth do
    plug Spender.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end


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

  # maybe logged in
  scope "/", SpenderWeb do
    pipe_through [:browser, :auth]

    get "/", UserController, :index
    post "/", UserController, :login
    post "/logout", UserController, :logout
  end

  # Definitely logged in
  scope "/", SpenderWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", UserController, :secret
  end

  scope "/api", SpenderWeb do
    pipe_through :browser # Use the default browser stack
    get "/", WelcomeController, :index

    resources "/users", UserController
  end

  # scope "/", SpenderWeb do
  #   get "/redirect_test", WelcomeController, :redirect_test, as: :redirect_test
  # end
end
