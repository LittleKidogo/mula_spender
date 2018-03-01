defmodule SpenderWeb.AuthView do
  @moduledoc false
  use SpenderWeb, :view
  use JaSerializer.PhoenixView

  attributes [:first_name, :last_name, :provider, :email, :token]
end
