defmodule SpenderWeb.WelcomeController do
  use SpenderWeb, :controller

  def index(conn, _params) do
    text conn, "hello there"
  end

end
