defmodule PayPhoenixWeb.UserController do
  use PayPhoenixWeb, :controller

  alias PayPhoenix.User

  action_fallback PayPhoenixWeb.FallbackController

  def store(conn, params) do
    with {:ok, %User{} = user} <- PayPhoenix.create_user(params) do
      conn
      |> put_status(:created)
      |> render("store.json", user: user)
    end
  end

  def index(conn, _params) do
    users = PayPhoenix.get_all_users()
    render(conn, "index.json", users: users)
  end
end
