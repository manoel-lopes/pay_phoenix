defmodule PayPhoenix do
  alias PayPhoenix.User.Store, as: Store
  alias PayPhoenix.Account.{Deposit, Withdraw, Transaction}

  defdelegate create_user(params), to: Store, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
