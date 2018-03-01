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
    plug :accepts, ["json-api", "json"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
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

    get "/:provider/callback", AuthController, :new
  end

  scope "/", SpenderWeb do
    pipe_through [:browser, :auth]

    get "/", AuthController, :welcome
  end

  # ensure auth pipeline
  scope "/", SpenderWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", AuthController, :secret
  end

  scope "/api", SpenderWeb do
    pipe_through :api # Use the default browser stack
    resources "/users", UserController, except: [:new, :edit]
  end
end
