defmodule Todolist.Account.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:username, :string)
    field(:role, :string, default: "user")

    pow_user_fields()

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^\S+@\S+.\S+$/)
    |> validate_inclusion(:role, ~w(user manager general_manager))
    |> unique_constraint(:username, message: "Username already exists")
    |> unique_constraint(:email, message: "Email already exists")
    |> pow_changeset(attrs)
  end
end
