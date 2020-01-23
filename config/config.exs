# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :distributed_phoenix_chat, DistributedPhoenixChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U8Fdlz2PQOpaqlCUcZcMpM1PAz8p2aikBns7RPqzNv2Z6/A1sO6lKwCB/myA/Z3r",
  render_errors: [view: DistributedPhoenixChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DistributedPhoenixChat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
