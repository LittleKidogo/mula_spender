defmodule SpenderWeb.UserView do
  use SpenderWeb, :view

  def render("index.json", %{users: users}) do
    %{users: Enum.map(users, &user_json/1)}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, SpenderWeb, "user.json")}
  end

  def user_json(user) do
    %{name: user.name}
  end 
end
