defmodule SpenderWeb.AuthController do
  @moduledoc """
  Controller to handle ueberauth responses
  """
  use SpenderWeb, :controller
  plug(Ueberauth)

  alias Spender.{Accounts, Auth.Guardian}

  @doc false
  def secret(conn, _params) do
    conn |> render("show.json-api", data: %{})
  end

  @doc """
  Callback function for federated auth providers to call with identification
  information
  """
  @spec login(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def login(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      firstname: auth.info.first_name,
      lastname: auth.info.last_name,
      email: auth.info.email,
      provider: "google"
    }

    create(conn, user_params)
  end

  def login(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_status(401)
    |> render("show.json-api", data: %{"error" => "Failed to Authenticate"})
  end

  @doc """
  If This function can pick a user, then lets proceed to sign them in and
  add their details to the session. Otherwise it creates a new user provided
  validation passes
  """
  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, user_params) do
    case insert_or_update_user(user_params) do
      {:ok, user} ->
        # encode a token for current_user
        {:ok, token, _} = Guardian.encode_and_sign(user)

        conn
        |> put_resp_header("authorization", "Bearer #{token}")
        |> Guardian.Plug.sign_in(user)
        |> render("show.json-api", data: user)

      {:error, _reason} ->
        conn
        |> put_status(422)
        |> render("show.json-api", data: %{"error" => "user"})
    end
  end

  @doc """
  This function to signs a user out of a sesssion using the Guardian.Plug.sign_out()
  call
  """
  @spec logout(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end

  @spec insert_or_update_user(map) :: {:ok, User.t()} | {:error, any()}
  defp insert_or_update_user(%{email: email} =  map) do
    case Accounts.get_by_email(email) do
      nil ->
        Accounts.create_user(map)

      user ->
        {:ok, user}
    end
  end
end
