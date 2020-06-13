# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :minesweeper_duel,
  ecto_repos: [MinesweeperDuel.Repo]

# Configures the endpoint
config :minesweeper_duel, MinesweeperDuelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iMj8snX9HxDEpH1KJpf76HqTrYdETNOnaexBY5nKDPRa0vX2wSnzi03Y/jb84nK0",
  render_errors: [view: MinesweeperDuelWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MinesweeperDuel.PubSub,
  live_view: [signing_salt: "zJYjFnOO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
