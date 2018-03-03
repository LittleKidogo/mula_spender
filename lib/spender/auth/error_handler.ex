defmodule Spender.Auth.ErrorHandler do
  use SpenderWeb, :controller

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_status(401)
    |> render(SpenderWeb.TokenView, "401.json", message: to_string(type))
  end
end
