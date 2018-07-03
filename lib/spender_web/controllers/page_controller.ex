defmodule SpenderWeb.PageController do
  @moduledoc """
  Controller to handle display of pages when the API is accessed from the browser
  """
  use SpenderWeb, :controller

  def index(conn, _) do
    text conn, "Hello"
  end
end
