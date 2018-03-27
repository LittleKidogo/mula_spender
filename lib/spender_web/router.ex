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
    plug SpenderWeb.Context
  end

  # routes that allow users whether they are logged or not
  pipeline :auth do
    plug Spender.Auth.BearerAuth
  end

  # routes that require authentication
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end


# Add a scope for authorization
  scope "/auth", SpenderWeb do
    pipe_through [:api]

    get "/:provider", AuthController, :request

    get "/:provider/callback", AuthController, :login

    get "/:provider/logout", AuthController, :logout    
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: SpenderWeb.Schema
  end

  scope "/api" do
    pipe_through [:api, :auth, :ensure_auth]
    get "/another", AuthController, :secret
    resources "/users", UserController
  end

end
