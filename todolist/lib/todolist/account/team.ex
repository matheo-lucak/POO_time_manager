defmodule Todolist.Account.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolist.Account

  schema "teams" do
    field(:name, :string)
    belongs_to(:created_by, Account.User, foreign_key: :creator_id)

    many_to_many(:managers, Account.User, join_through: "managers_teams", on_replace: :delete)
    many_to_many(:employees, Account.User, join_through: "employees_teams", on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name, :created_by])
  end
end
