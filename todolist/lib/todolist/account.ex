defmodule Todolist.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Todolist.Repo

  alias Todolist.Account.User

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
  defp filter_email(query, email), do: from(u in query, where: u.email == ^email)

  defp filter_username(query, nil), do: query
  defp filter_username(query, username), do: from(u in query, where: u.username == ^username)

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
  def get_user!(id), do: Repo.get!(User, id)

  defmodule UserNotFoundError do
    defexception message: "User not found"
  end

  defimpl Plug.Exception, for: Account.UserNotFoundError do
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

  def unsafe_update_user(%User{} = user, attrs) do
    user
    |> User.unsafe_changeset(attrs)
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

  def is_user(%User{} = user) do
    user.role == "user"
  end

  def is_manager(%User{} = user) do
    user.role == "manager"
  end

  def is_general_manager(%User{} = user) do
    user.role == "general_manager"
  end

  def is_manager_or_general_manager(%User{} = user) do
    is_manager(user) || is_general_manager(user)
  end

  alias Todolist.Account.Team

  defmodule TeamNotFoundError do
    defexception message: "Team not found"
  end

  defimpl Plug.Exception, for: TeamNotFoundError do
    def status(_exception), do: 404
  end

  defmodule UserIsNotTeamManagerError do
    defexception message: "User is not a manager of the team"
  end

  defimpl Plug.Exception, for: UserIsNotTeamManagerError do
    def status(_exception), do: 403
  end

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
    |> Repo.preload([:created_by, :managers, :employees])
  end

  def list_teams_user(userID) do
    from(t in Team, where: t.creator_id == ^userID)
    |> Repo.all()
    |> Repo.preload([:created_by, :managers, :employees])
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id) do
    case(Repo.get(Team, id)) do
      nil ->
        raise TeamNotFoundError

      team ->
        team
        |> Repo.preload([:created_by, :managers, :employees])
    end
  end

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(userID, attrs \\ %{}) do
    assoc =
      get_user!(userID)
      |> Ecto.build_assoc(:created_teams, name: "Default team name")
      |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end

  @doc """
  Raises `UserIsNotTeamManagerError`
  """
  def user_is_team_manager!(%Team{} = team, %User{} = user) do
    team = team |> Repo.preload(:managers)

    case Enum.any?(team.managers, fn manager -> manager == user.id end) do
      true -> true
      false -> raise UserIsNotTeamManagerError
    end
  end

  def team_add_managers(%Team{} = team, ids_to_add \\ []) do
    team = team |> Repo.preload(:managers)

    managers =
      Enum.map(ids_to_add, &get_user!/1)
      |> Enum.filter(&is_manager_or_general_manager/1)

    merged_managers = Enum.concat(managers, team.managers) |> Enum.uniq_by(fn x -> x.id end)

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:managers, merged_managers)
    |> Repo.update()
  end

  def team_add_employees(%Team{} = team, ids_to_add \\ []) do
    team = team |> Repo.preload(:employees)

    employees = Enum.map(ids_to_add, &get_user!/1)

    merged_employees = Enum.concat(employees, team.employees) |> Enum.uniq_by(fn x -> x.id end)

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:employees, merged_employees)
    |> Repo.update()
  end

  def team_delete_managers(%Team{} = team, ids_to_delete \\ []) do
    team = team |> Repo.preload(:managers)

    filtered_managers =
      team.managers
      |> Enum.filter(fn manager -> !Enum.any?(ids_to_delete, fn i -> i == manager.id end) end)

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:managers, filtered_managers)
    |> Repo.update()
  end

  def team_delete_employees(%Team{} = team, ids_to_delete \\ []) do
    team = team |> Repo.preload(:employees)

    filtered_employees =
      team.employees
      |> Enum.filter(fn manager -> !Enum.any?(ids_to_delete, fn i -> i == manager.id end) end)

    team
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:employees, filtered_employees)
    |> Repo.update()
  end
end
