defmodule SpenderWeb.UserControllerTest do
  use SpenderWeb.ConnCase


  @valid_attrs %{name: "Technology"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "index renders list of users" do
      conn = build_conn()
      user = insert(:user)

      conn = get conn, user_path(conn, :index)

      assert json_response(conn, 200) == %{"users" => [%{"name" => user.name}]}
    end
  end
end
