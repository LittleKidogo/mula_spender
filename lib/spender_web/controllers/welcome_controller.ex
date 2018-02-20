defmodule SpenderWeb.WelcomeController do
  use SpenderWeb, :controller
  plug Ueberauth


  def show(conn, %{"messenger" => messenger} = _params) do
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

  def redirect_test(conn, _params) do
    text conn, "Redirecto!"
  end
end
