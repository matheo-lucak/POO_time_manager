defmodule Todolist.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  import Plug
  alias Todolist.Repo

  alias Todolist.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Returns the list of maybe filtered users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users(filter \\ %{}) do
    User
    |> apply_filter(filter)
    |> Repo.all()
  end

  defp apply_filter(query, filter) do
    query
    |> filter_email(filter["email"])
    |> filter_username(filter["username"])
  end

  defp filter_email(query, nil), do: query
  defp filter_email(query, email), do: from u in query, where: u.email == ^email

  defp filter_username(query, nil), do: query
  defp filter_username(query, username), do: from u in query, where: u.username == ^username

  @doc """
  Gets a single user.

  Return nil if the User does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  def get_user(id), do: Repo.get(User, id)

  defmodule UserNotFoundError do
    defexception message: "User not found"
  end

  defimpl Plug.Exception, for: UserNotFoundError do
    def status(_exception), do: 404
  end

  @doc """
  Verify if a user exists
  Raises UserNotFoundError if user has been found
  """
  def verify_user!(id) do
    case Repo.get(User, id) do
      nil -> raise UserNotFoundError
      user -> user
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
