defmodule PayPhoenixWeb.UsersController do
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
end
