defmodule TodolistWeb.Router do
  use TodolistWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TodolistWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Todolist.Auth.AuthFlow, otp_app: :todolist
  end

  pipeline :manager do
    plug TodolistWeb.EnsureRolePlug, [:manager, :general_manager]
  end

  pipeline :general_manager do
    plug TodolistWeb.EnsureRolePlug, :general_manager
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
    error_handler: TodolistWeb.AuthErrorHandler
  end


  scope "/api/auth", TodolistWeb.Controllers do
    pipe_through :api

    post "/register", UserRegistration, :register
    post "/login", UserLogin, :login
  end

  scope "/api", TodolistWeb do
    pipe_through [:api, :api_protected]

    resources "/users", UserController

    get "/clocks/:userID", ClockController, :index
    post "/clocks/:userID", ClockController, :toggle
    post "/clocks/reset/:userID", ClockController, :reset

    get "/workingtimes/:userID", WorkingTimeController, :index
    get "/workingtimes/:userID/:id", WorkingTimeController, :show
    post "/workingtimes/:userID", WorkingTimeController, :create
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:id", WorkingTimeController, :delete
  end

  scope "/api", TodolistWeb do
    pipe_through [:api, :api_protected, :general_manager]

    put "/users/promote/:userID", UserController, :promote
    put "/users/demote/:userID", UserController, :demote
    get "/teams/", TeamController, :index
  end

  scope "/api", TodolistWeb do
    pipe_through [:api, :api_protected, :manager]

    post "/teams/", TeamController, :create
    get "/teams/:userID", TeamController, :index
    post "/teams/:teamID/manager", TeamController, :add_manager
    post "/teams/:teamID/employee", TeamController, :add_employee
    delete "/teams/:teamID/manager", TeamController, :delete_manager
    delete "/teams/:teamID/employee", TeamController, :delete_employee
  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
