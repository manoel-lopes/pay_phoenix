defmodule PayPhoenixWeb.AccountController do
  use PayPhoenixWeb, :controller

  alias PayPhoenix.Account
  alias PayPhoenix.Account.Transaction.Response, as: TransactionResponse

  action_fallback PayPhoenixWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- PayPhoenix.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- PayPhoenix.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction} <- PayPhoenix.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
