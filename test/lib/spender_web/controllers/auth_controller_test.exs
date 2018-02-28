defmodule SpenderWeb.AuthControllerTest do
  use SpenderWeb.ConnCase

  describe "AuthController" do
    test "redirects user to Google for Authentication", %{conn: conn} do
      conn = get conn, "/auth/google"
      assert redirected_to(conn, 302)
    end
  end

end
