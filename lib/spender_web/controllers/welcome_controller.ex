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

  def showtext(conn,%{"id" => id}) do
    text conn, "Showing item id #{id}"
  end

  def showuser(conn,%{"id" => id}) do
    user = %{name: "Sample", age: id, id: id}
    json conn, user
  end

  def htmluser(conn,%{"id" => id}) do
    user = %{name: "Sample", age: id, id: id}
    html conn, """
    <html>
      <p>Name: #{user.name}</p>
      <p>Age: #{user.age} years</p>
    </html>
    """
  end

end
