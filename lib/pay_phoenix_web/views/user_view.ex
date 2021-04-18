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
end
