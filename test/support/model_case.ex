defmodule Spender.ModelCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's model layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Spender.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Spender.ModelCase
      import Spender.Factories
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Spender.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Spender.Repo, {:shared, self()})
    end

    :ok
  end
end
