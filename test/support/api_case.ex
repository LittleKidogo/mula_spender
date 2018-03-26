defmodule SpenderWeb.ApiCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection working
  on the API endpoints

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  import Spender.Factories
  use Phoenix.ConnTest

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import SpenderWeb.Router.Helpers
      alias Spender.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Spender.ModelCase
      import Spender.Factories
      import Spender.TestHelpers



      # The default endpoint for testing
      @endpoint SpenderWeb.Endpoint
    end
  end


  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Spender.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Spender.Repo, {:shared, self()})
    end

    # modify a test using a tag
    {conn, current_user} = cond do
      tags[:authenticated] ->
        build_conn()
        |> add_authentication_headers(tags[:authenticated])
      true ->
        conn = build_conn()
        {conn, nil}
    end


    {:ok, conn: conn, current_user: current_user}
  end

  #add information to connection
  defp add_authentication_headers(conn, true) do
    user = insert(:user)

    conn = conn |> Spender.AuthenticationTestHelpers.authenticate(user)
    {conn, user}
  end
end
