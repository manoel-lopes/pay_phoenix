defmodule PayPhoenix do
  alias PayPhoenix.Users.Create, as: UserCreate

  alias PayPhoenix.Accounts.{Deposit, Withdraw, Transaction}

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call

  defdelegate withdraw(params), to: Withdraw, as: :call

  defdelegate transaction(params), to: Transaction, as: :call
end
