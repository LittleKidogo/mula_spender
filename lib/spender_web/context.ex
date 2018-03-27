defmodule SpenderWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token ] <- get_req_header(conn, "authorization"),
      {:ok, user, _claims} = Spender.Auth.Guardian.resource_from_token(token) do

       %{current_user: user}
    else
      _ -> %{}
    end
  end
end
