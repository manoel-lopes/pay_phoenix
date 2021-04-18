defmodule PayPhoenixWeb.Router do

  use PayPhoenixWeb, :router

  import Plug.BasicAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :basic_auth, Application.compile_env!(:pay_phoenix, :basic_auth)
  end

  scope "/users", PayPhoenixWeb do
    pipe_through :api

    post "/", UserController, :store
  end

  scope "/accounts", PayPhoenixWeb do
    pipe_through [:api, :auth]

    post "/:id/deposit", AccountController, :deposit
    post "/:id/withdraw", AccountController, :withdraw
    post "/transaction", AccountController, :transaction

    if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PayPhoenixWeb.Telemetry
    end
  end
end
end
