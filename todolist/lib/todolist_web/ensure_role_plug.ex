defmodule TodolistWeb.EnsureRolePlug do
  @moduledoc """
  This plug ensures that a user has a particular role.

  ## Example

      plug TodolistWeb.EnsureRolePlug, [:user, :manager]

      plug TodolistWeb.EnsureRolePlug, :manager

      plug TodolistWeb.EnsureRolePlug, ~w(user manager general_manager)a
  """
  import Plug.Conn, only: [halt: 1]

  alias TodolistWeb.Router.Helpers, as: Routes
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.Plug

  use TodolistWeb, :controller

  @doc false
  @spec init(any()) :: any()
  def init(config), do: config

  @doc false
  @spec call(Conn.t(), atom() | binary() | [atom()] | [binary()]) :: Conn.t()
  def call(conn, roles) do

    conn.private[:current_user]
    |> has_role?(roles)
    |> maybe_halt(conn)
  end

  defp has_role?(nil, _roles), do: false
  defp has_role?(user, roles) when is_list(roles), do: Enum.any?(roles, &has_role?(user, &1))
  defp has_role?(user, role) when is_atom(role), do: has_role?(user, Atom.to_string(role))
  defp has_role?(%{role: role}, role), do: true
  defp has_role?(_user, _role), do: false

  defp maybe_halt(true, conn), do: conn
  defp maybe_halt(_any, conn) do
    conn
    |> put_status(403)
    |> json(%{error: %{code: 403, message: "The user has insufficient role"}})
    |> halt()
  end
end
