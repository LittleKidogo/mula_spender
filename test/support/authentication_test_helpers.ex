defmodule Spender.AuthenticationTestHelpers do
  use Phoenix.ConnTest
  import Spender.Factories

  #when given a connection to authenticate create a user call auth witht user and conn
  def authenticate(conn) do
    user = insert(:user)
    conn
    |> authenticate(user)
  end

  def authenticate(conn, user) do
    # get the token for the user
    {:ok, token, _} = user |> CodeCorps.Guardian.encode_and_sign()

    # add the users token to the request header
    conn
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
