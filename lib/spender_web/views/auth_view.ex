defmodule SpenderWeb.AuthView do
  @moduledoc false
  use SpenderWeb, :view
  use JaSerializer.PhoenixView

  attributes [:firstname, :lastname, :provider, :email, :token]
end
