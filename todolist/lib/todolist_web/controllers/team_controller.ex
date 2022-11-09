defmodule TodolistWeb.TeamController do
  use TodolistWeb, :controller

  alias Todolist.Account
  alias Todolist.Account.Team

  action_fallback(TodolistWeb.FallbackController)

  def index(conn, %{"userID" => userID}) do
    teams = Account.list_teams_user(userID)
    render(conn, "index.json", teams: teams)
  end

  def index(conn, _params) do
    teams = Account.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    userID = conn.private[:current_user].id

    with {:ok, %Team{} = team} <- Account.create_team(userID, team_params) do
      team = Account.get_team!(team.id)

      conn
      |> put_status(:created)
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Account.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Account.get_team!(id)

    with {:ok, %Team{} = team} <- Account.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Account.get_team!(id)

    with {:ok, %Team{}} <- Account.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_manager(conn, %{"teamID" => teamID, "IDs" => managersIDs}) do
    team = Account.get_team!(teamID)

    current_user = conn.private[:current_user]

    if !Account.is_general_manager(current_user) do
      Account.user_is_team_manager!(team, current_user)
    end

    with {:ok, %Team{} = team} <- Account.team_add_managers(team, managersIDs) do
      render(conn, "show.json", team: team)
    end
  end

  def add_employee(conn, %{"teamID" => teamID, "IDs" => employeesIDs}) do
    team = Account.get_team!(teamID)

    current_user = conn.private[:current_user]

    if !Account.is_general_manager(current_user) do
      Account.user_is_team_manager!(team, current_user)
    end

    with {:ok, %Team{} = team} <- Account.team_add_employees(team, employeesIDs) do
      render(conn, "show.json", team: team)
    end
  end

  def delete_manager(conn, %{"teamID" => teamID, "IDs" => managersIDs}) do
    team = Account.get_team!(teamID)

    current_user = conn.private[:current_user]

    if !Account.is_general_manager(current_user) do
      Account.user_is_team_manager!(team, current_user)
    end

    with {:ok, %Team{} = team} <- Account.team_delete_managers(team, managersIDs) do
      render(conn, "show.json", team: team)
    end
  end

  def delete_employee(conn, %{"teamID" => teamID, "IDs" => employeesIDs}) do
    team = Account.get_team!(teamID)

    current_user = conn.private[:current_user]

    if !Account.is_general_manager(current_user) do
      Account.user_is_team_manager!(team, current_user)
    end

    with {:ok, %Team{} = team} <- Account.team_delete_employees(team, employeesIDs) do
      render(conn, "show.json", team: team)
    end
  end
end
