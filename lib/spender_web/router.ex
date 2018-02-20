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


  end

  # Definitely logged in
  scope "/", SpenderWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", UserController, :secret
  end

  scope "/api", SpenderWeb do
  end

  # scope "/", SpenderWeb do
  #   get "/redirect_test", WelcomeController, :redirect_test, as: :redirect_test
  # end
end
