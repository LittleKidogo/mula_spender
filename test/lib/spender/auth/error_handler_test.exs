defmodule Spender.Auth.ErrorHandlerTest do
  use SpenderWeb.ConnCase

alias Spender.Auth.ErrorHandler

describe "ErrorHandler" do
  test "returns 401 status and Correct Message", %{conn: conn} do
    type = "Not Allowed"
    result = ErrorHandler.auth_error(conn, {type, []}, [])
    assert result.status == 401
    assert result.resp_body == "Not Allowed"
  end
end

end
