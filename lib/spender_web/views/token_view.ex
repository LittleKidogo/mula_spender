defmodule SpenderWeb.TokenView do
  @moduledoc """
  View for auth token
  """
  use SpenderWeb, :view

  def render("401.json", %{message: message}) do
    %{
      errors: [
        %{
          id: "UNAUTHORISED",
          title: "401 Unauthorized",
          detail: message,
          status: 401
        }
      ]
    }
  end
end
