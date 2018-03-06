defmodule SpenderWeb.UserControllerTest do
  use SpenderWeb.ApiCase


  @create_attrs %{email: "some email", provider: "some provider", token: "sometoken", first_name: "Zacck", last_name: "Osiemo"}
  @update_attrs %{email: "some updated email", provider: "some updated provider", token: "someupdatedtoken"}
  @invalid_attrs %{avatar: "", email: ""}

   describe "index" do
    @tag :authenticated
    test "lists all users", %{conn: conn, current_user: _user} do
      conn = get conn, user_path(conn, :index)
      assert conn |> json_response(200)
    end
   end

  describe "show" do
    @tag :authenticated
    test "shows the user details", %{conn: conn, current_user: user} do
      conn = get conn, user_path(conn, :show, user.id)

      conn
      |> json_response(200)
      |> assert_id_in_response(user.id)
    end
  end

  describe "create user" do
    @tag :authenticated
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert conn |> json_response(201)
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    @tag :authenticated
    test "renders user when data is valid", %{conn: conn, current_user: user} do
      conn = put conn, user_path(conn, :update, user), user: @update_attrs

      conn
      |> json_response(200)
      |> assert_id_in_response(user.id)
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn, current_user: user} do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
