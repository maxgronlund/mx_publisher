use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mx_publisher, MxPublisherWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :mx_publisher, MxPublisher.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "maxgronlund",
  password: "",
  database: "mx_publisher_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
