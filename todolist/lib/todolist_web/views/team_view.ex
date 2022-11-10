defmodule TodolistWeb.TeamView do
  use TodolistWeb, :view
  alias TodolistWeb.TeamView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
      created_by: TodolistWeb.UserView.render("show.json", %{user: team.created_by}).data,
      managers: TodolistWeb.UserView.render("index.json", %{users: team.managers}).data,
      employees: TodolistWeb.UserView.render("index.json", %{users: team.employees}).data
    }
  end
end
