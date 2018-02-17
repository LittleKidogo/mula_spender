defmodule SpenderWeb.WelcomeController do
  use SpenderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
