defmodule Todolist.Account.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:username, :string)

    pow_user_fields()

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^\S+@\S+.\S+$/)
    |> unique_constraint(:username, message: "Username already exists")
    |> unique_constraint(:email, message: "Email already exists")
    |> pow_changeset(attrs)
  end
end
