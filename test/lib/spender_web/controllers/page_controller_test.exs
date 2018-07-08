defmodule SpenderWeb.PageControllerTest do
  use SpenderWeb.ApiCase
  import Plug.Test

  describe "Page Controller" do
     test "renders the homepage on the root url", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200)
    end
  end
end
