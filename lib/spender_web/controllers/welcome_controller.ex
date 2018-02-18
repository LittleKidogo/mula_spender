defmodule SpenderWeb.WelcomeController do
  use SpenderWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "Welcome the budget app I am a flash message")
    |> put_flash(:error, "Hey we have an error")
    |> render("index.html")
  end

  def show(conn, %{"messenger" => messenger} = params) do
    render conn, "show.html", messenger: messenger
  end
end
