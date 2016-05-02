ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Blogit.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Blogit.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Blogit.Repo)

