defmodule SpenderWeb.PageControllerTest do
  use SpenderWeb.ApiCase

  describe "Page Controller" do
     test "renders the homepage on the root url", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "Welcome to the Mula API."
    end
  end
end
