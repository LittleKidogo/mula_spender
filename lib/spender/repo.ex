defmodule Spender.Repo do
  @moduledoc """
  Module to use for Database Interactions
  """
  use Ecto.Repo, otp_app: :spender

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
