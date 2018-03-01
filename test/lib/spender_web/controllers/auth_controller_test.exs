defmodule SpenderWeb.AuthControllerTest do
  use SpenderWeb.ApiCase

  alias Spender.{Accounts.User, Repo}
  alias AuthController

  @ueberauth_auth %{credentials: %{token: "kbikn86917njbn"}, info: %{first_name: "Zacck", last_name: "Osiemo", email: "zacck@moneylog.com"}, provider: "google"}
  @error %{credentials: %{token: "" }, info: %{first_name: "Zacck", last_name: "Osiemo", email: "zacck@moneylog.com"}, provider: "google"}
  describe "AuthController" do
    test "redirects user to Google for Authentication", %{conn: conn} do
      conn = get conn, "/auth/google"
      assert redirected_to(conn, 302)
    end

    test "creates and returns user from google information",%{conn: conn} do
      #mock a response from google
      conn = conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      |> get("/auth/google/callback") #use the response

      assert json_response(conn, 200)
      user = Repo.get_by(User, email: @ueberauth_auth.info.email)
      assert Repo.aggregate(User, :count, :id) == 1
      assert user.email == @ueberauth_auth.info.email
    end

    test "errors out if error when creating user", %{conn: conn} do
      conn = conn
      |> assign(:ueberauth_auth, @error)
      |> get("/auth/google/callback")
      assert json_response(conn, 422)
    end
  end

end
