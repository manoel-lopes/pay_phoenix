defmodule PayPhoenix.Users.CreateTest do
  use PayPhoenix.DataCase, async: true

  alias PayPhoenix.User
  alias PayPhoenix.User.Store

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "user",
        password: "12345678",
        nickname: "nusernick",
        email: "user@gmail.com",
        age: 22
      }

      {:ok, %User{id: user_id}} = Store.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "user", age: 22, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "user",
        nickname: "nusernick",
        email: "user@gmail.com",
        age: 15
      }

      {:error, changeset} = Store.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
