defmodule PayPhoenixWeb.UsersViewTest do
  use PayPhoenixWeb.ConnCase, async: true

  import Phoenix.View

  alias PayPhoenix.{Account, User}
  alias PayPhoenixWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Manoel Lopes",
      password: "12345678",
      nickname: "manoel-lopes",
      email: "manoel.lopes@gmail.com",
      age: 22
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      PayPhoenix.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response =  %{
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Manoel Lopes",
        nickname: "manoel-lopes"
      }
    }

     assert expected_response == response
    end
end
