defmodule SpenderWeb.AuthController do
  @moduledoc """
  Controller to handle ueberauth responses
  """
  use SpenderWeb, :controller
  plug Ueberauth

  alias Spender.{Accounts, Accounts.User, Auth.Guardian}


  action_fallback SpenderWeb.FallbackController

  def secret(conn, _params) do
    text conn, "This is a secret page"
  end

  # handle callback payload
  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, first_name: auth.info.first_name, last_name: auth.info.last_name, email: auth.info.email, provider: "google"}

    create(conn, user_params)
  end

  # if we can pick a user lets proceed to sign them in and add their details to the session

  def create(conn, changeset) do
      with {:ok, %User{} = user} <- insert_or_update_user(changeset)
      do
        Guardian.Plug.sign_in(conn, user)
        render(conn, "show.json-api", data: user)
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
