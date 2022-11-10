defmodule Todolist.Account.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset
  alias Todolist.Account

  schema "users" do
    field(:username, :string)
    field(:role, :string, default: "user")
    has_many(:created_teams, Account.Team, foreign_key: :creator_id)

    many_to_many(:manager_of, Account.Team, join_through: "managers_teams", on_replace: :delete)
    many_to_many(:employee_of, Account.Team, join_through: "employees_teams", on_replace: :delete)

    pow_user_fields()

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    unsafe_changeset(user, attrs)
    |> pow_changeset(attrs)
  end

  def unsafe_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> cast_assoc(:created_teams)
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^\S+@\S+.\S+$/)
    |> validate_inclusion(:role, ~w(user manager general_manager))
    |> unique_constraint(:username, message: "Username already exists")
    |> unique_constraint(:email, message: "Email already exists")
  end
end
