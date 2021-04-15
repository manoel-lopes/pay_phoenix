defmodule PayPhoenixWeb.AccountsControllerTest do
  use PayPhoenixWeb.ConnCase, async: true

  alias PayPhoenix.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Manoel Lopes",
        password: "12345678",
        nickname: "manoel-lopes",
        email: "manoel.lopes@gmail.com",
        age: 22
      }

      {:ok, %User{account: %Account{id: account_id}}} = PayPhoenix.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic dXNlcjoxMjM0NTY3OA==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "5.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{
                 "balance" => "5.00",
                 "id" => _id
               },
               "message" => "Balance changed successfully"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "invalid_value"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)


      expected_response = %{"messsgae" => "Invalid deposit value!"}

      assert  expected_response == response
    end
  end
end
