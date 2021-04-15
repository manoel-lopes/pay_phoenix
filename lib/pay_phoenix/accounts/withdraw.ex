defmodule PayPhoenix.Accounts.Withdraw do
  alias PayPhoenix.Accounts.Operation
  alias PayPhoenix.Repo

  def call( params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{withdraw: account}} -> {:ok, account}
    end
  end
end
