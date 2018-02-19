defmodule SpenderWeb.UserController do
  use SpenderWeb, :controller

  alias Spender.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.json", users: users
  end
end
