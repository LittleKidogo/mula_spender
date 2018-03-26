defmodule SpenderWeb.UserController do
  use SpenderWeb, :controller

  alias Spender.Accounts
  alias Spender.Accounts.User

  action_fallback SpenderWeb.FallbackController


  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json-api", data: user)
    end
  end
end
