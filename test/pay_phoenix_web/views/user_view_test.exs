defmodule PayPhoenixWeb.UserViewTest do
  use PayPhoenixWeb.ConnCase, async: true

  import Phoenix.View

  alias PayPhoenix.{Account, User}
  alias PayPhoenixWeb.UserView

  test "renders create.json" do
    params = %{
      name: "user",
      password: "12345678",
      nickname: "usernick",
      email: "user@gmail.com",
      age: 22
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      PayPhoenix.create_user(params)

    response = render(UserView, "create.json", user: user)

    expected_response =  %{
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "user",
        nickname: "usernick"
      }
    }

     assert expected_response == response
    end
end
