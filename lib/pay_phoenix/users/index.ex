defmodule PayPhoenix.Users.Index do
  alias PayPhoenix.{Repo, User}

  def call() do
    Repo.all(User)
    |> Repo.preload(:account)
  end
end
