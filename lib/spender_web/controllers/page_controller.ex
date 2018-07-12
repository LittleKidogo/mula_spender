defmodule SpenderWeb.PageController do
  @moduledoc """
  Controller to handle display of pages when the API is accessed from the browser
  """
  use SpenderWeb, :controller
  @doc """
  This function takes a Connection Struct and any other parameter which may be optional
  it then convertes this to content that can be displayed on a web page and stores it in
  a Connection struct and returns the struct.
  """
  @spec index(Plug.Conn.t(), any())::Plug.Conn.t()
  def index(conn, _) do
    render conn, "page.html"
  end
end
