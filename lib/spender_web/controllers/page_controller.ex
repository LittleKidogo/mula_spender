defmodule SpenderWeb.PageController do
  @moduledoc """
  Controller to handle display of pages when the API is accessed from the browser
  """
  use SpenderWeb, :controller

  @doc """
  This function takes a Connection Struct and an optional parameter
  it then converts it and then renders the landing page for the root route of the Mula API
  """
  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _) do
    render(conn, "page.html")
  end
end
