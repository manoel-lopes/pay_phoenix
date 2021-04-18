defmodule PayPhoenixWeb.Router do

  use PayPhoenixWeb, :router

  import Plug.BasicAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :basic_auth, Application.compile_env!(:pay_phoenix, :basic_auth)
  end

  scope "/", PayPhoenixWeb do
    pipe_through :api

    post "/users", UsersController, :store
    get "/users", UsersController, :index
  end

  scope "/", PayPhoenixWeb do
    pipe_through [:api, :auth]

    post "accounts/:id/deposit", AccountsController, :deposit
    post "accounts/:id/withdraw", AccountsController, :withdraw
    post "accounts/transaction", AccountsController, :transaction

    if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PayPhoenixWeb.Telemetry
    end
  end
end
end
