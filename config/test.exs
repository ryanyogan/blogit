use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :blogit, Blogit.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :blogit, Blogit.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "blogit_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Minimimal effort in crypto for faster tests
config :comeonin, bcrypt_log_rounds: 4
