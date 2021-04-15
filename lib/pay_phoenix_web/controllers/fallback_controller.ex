defmodule PayPhoenixWeb.FallbackController do
  use PayPhoenixWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PayPhoenixWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
