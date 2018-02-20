defmodule Spender.Auth do
  use Spender.Model
  alias Comeonin.Bcrypt
  alias Spender.{User, Repo}

  def authenticate_user(username, plain_text_password) do
    query = from u in User, where: u.name == ^username
    Repo.one(query)
    |> check_password(plain_text_password)
  end

  defp check_password(nil, _), do: {:error , "Incorrect username or password"}

  defp check_password(user, plain_text_password) do
    case Bcrypt.checkpw(plain_text_password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end

  @doc """
 Returns an `%Ecto.Changeset{}` for tracking user changes.
 ## Examples
     iex> change_user(user)
     %Ecto.Changeset{source: %User{}}
 """
 def change_user(%User{} = user) do
   User.create_changeset(user, %{})
 end
end
