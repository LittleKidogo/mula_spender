defmodule Spender.Auth.ErrorHandler do
  @moduledoc """
  This module contains functions that we use to handle errors in the
  authentication context
  """
  use SpenderWeb, :controller

  @doc """
  This function takes a Connection Struct, an error tuple and an optional list of options
  It then converts the error tuple as a human readable error and puts the error in the
  Connection Struct and returns that struct
  """
  @spec auth_error(Plug.Conn.t(), tuple(), list()) :: Plug.Conn.t()
  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_status(401)
    |> render(SpenderWeb.TokenView, "401.json", message: to_string(type))
  end
end
