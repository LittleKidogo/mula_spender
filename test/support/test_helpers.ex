defmodule Spender.TestHelpers do
  use Phoenix.ConnTest
  import ExUnit.Assertions

  def ids_from_response(response) do
    Enum.map response["data"], fn(attribs) ->
      String.to_integer(attribs["id="])
    end
  end

  def assert_id_in_response(response, id) do
    assert String.to_integer(response["data"]["id"]) == id
    response
  end

  def assert_ids_in_response(response, ids) do
    assert response |> ids_from_response |> Enum.sort() == ids |> Enum.sort()
    response
  end

  def assert_attributes(response, expected) do
    assert response["attributes"] == expected
    response
  end
end
