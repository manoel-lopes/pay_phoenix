defmodule PayPhoenixWeb.UsersView do
  alias PayPhoenix.{Account, User}

  def render("store.json", %{user: %User{
          account: %Account{id: account_id, balance: balance},
          id: id,
          name: name,
          nickname: nickname
        }}) do
    %{
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
