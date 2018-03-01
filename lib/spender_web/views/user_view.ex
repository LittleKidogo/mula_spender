defmodule SpenderWeb.UserView do
  use SpenderWeb, :view
  use JaSerializer.PhoenixView

  attributes [:first_name, :last_name, :email, :provider]

end
