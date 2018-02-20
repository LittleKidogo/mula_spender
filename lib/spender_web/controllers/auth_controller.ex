defmodule SpenderWeb.AuthController do
  use SpenderWeb, :controller
  plug Ueberauth

  alias Spender.{Accounts, Accounts.User}

  def index(conn, _) do
    text conn, "welcome are you logged in?"
  end



  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, first_name: auth.info.first_name, last_name: auth.info.last_name, email: auth.info.email, provider: "google"}
    _changeset = User.changeset(%User{}, user_params)

    create(conn, user_params)
  end

  def create(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Thank you for signing in!")
        |> put_session(:user_id, user.id)
        |> text("Thank You for signing in!")
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> text("Error signing in")
    end
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
