defmodule PayPhoenixWeb.UsersController do
  use PayPhoenixWeb, :controller

  alias PayPhoenix.User

  action_fallback PayPhoenixWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- PayPhoenix.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
