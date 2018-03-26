defmodule SpenderWeb.AuthController do
  @moduledoc """
  Controller to handle ueberauth responses
  """
  use SpenderWeb, :controller
  plug Ueberauth

  alias Spender.{Accounts, Accounts.User, Auth.Guardian}

  def secret(conn, _params) do
    conn |> render("show.json-api", data: %{})
  end

  # handle callback payload
  def login(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, firstname: auth.info.first_name, lastname: auth.info.last_name, email: auth.info.email, provider: "google"}
    _changeset = User.changeset(%User{}, user_params)
    create(conn, user_params)
  end

  def login(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> render("show.json-api", data: %{"error" => "Failed to Authenticate"})
  end

  # if we can pick a user lets proceed to sign them in and add their details to the session
  def create(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        #encode a token for current_user
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

  # function to sign user
  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end



  defp insert_or_update_user(%{email: email}=changeset) do
    case Accounts.get_by_email(email) do
      nil ->
        Accounts.create_user(changeset)
      user ->
        {:ok, user}
    end
  end
end
