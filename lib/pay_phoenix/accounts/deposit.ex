defmodule PayPhoenix.Account.Deposit do
  alias Ecto.Multi
  alias PayPhoenix.{Account, Repo}

  def call(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account, value)
    end)
    |> run_transaction()
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account, not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sum_values(value)
    |> update_account(repo, account)
  end

  defp sum_values(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> validate_value()
    |> handle_cast(balance)
  end

  defp validate_value({:ok, value}) do
    case Decimal.negative?(value) do
      true -> :error
      false -> {:ok, value}
    end
  end

  defp validate_value(:error), do: :error

  defp handle_cast(:error, _balance), do: {:error, "Invalid deposit value!"}

  defp handle_cast({:ok, value}, balance), do: Decimal.add(balance, value)

  defp update_account({:error, _reason,} = error, _repo,_account), do: error

  defp update_account(value, repo, account) do
    params = %{balance: value}

    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end
end
