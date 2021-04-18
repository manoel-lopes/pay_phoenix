defmodule PayPhoenixWeb.UserView do
  alias PayPhoenix.{Account, User}

  def render("store.json", %{
        user: %User{
          id: id,
          name: name,
          nickname: nickname,
          account: %Account{id: account_id, balance: balance}
        }
      }) do
    %{
      id: id,
      name: name,
      nickname: nickname,
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("index.json", %{users: users}) do
    Enum.map(users, fn user ->
      %{
        id: user.id,
        name: user.name,
        nickname: user.nickname,
        account: %{
          id: user.account.id,
          balance: user.account.balance
        }
      }
    end)
  end
end