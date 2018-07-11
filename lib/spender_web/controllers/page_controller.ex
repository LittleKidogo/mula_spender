defmodule SpenderWeb.PageController do
  @moduledoc """
  Controller to handle display of pages when the API is accessed from the browser
  """
  use SpenderWeb, :controller

  # this function needs an @doc attribute
  # this function needs a spec
  def index(conn, _) do
    render conn, "page.html"
  end
end
