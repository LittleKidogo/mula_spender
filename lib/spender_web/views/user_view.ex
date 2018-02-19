defmodule SpenderWeb.UserView do
  use SpenderWeb, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, SpenderWeb, "user.json")}
  end
end
