defmodule SpenderWeb.AuthControllerTest do
  use SpenderWeb.ConnCase

  alias Spender.{Accounts.User, Repo}
  alias SpenderWeb.AuthController

  @ueberauth_auth %{credentials: %{token: "kbikn86917njbn"}, info: %{first_name: "Zacck", last_name: "Osiemo", email: "zacck@moneylog.com"}, provider: "google",}

  describe "AuthController" do
    test "redirects user to Google for Authentication", %{conn: conn} do
      conn = get conn, "/auth/google"
      assert redirected_to(conn, 302)
    end

    test "creates and returns user from google information",%{conn: conn} do
      #mock a response from google
      conn = conn
      |> assign(:ueberauth_auth, @ueberauth_auth)
      #|> get("/auth/google/callback") #use the response
      processed_conn = AuthController.new(conn, [])

      assert json_response(processed_conn, 302) == %{"users" => [%{
        "token" => @ueberauth_auth.credentials.token,
        "first_name" => @ueberauth_auth.info.first_name,
        "last_name" =>  @ueberauth_auth.info.last_name,
        "email" => @ueberauth_auth.info.email
        }]
      }
      user = Repo.get_by(User, email: @ueberauth_auth.info.email)
      assert Repo.aggregate(User, :count, :id) == 1
      assert user.email == @ueberauth_auth.info.email
    end
  end

end
