use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :FutureMadeConcerts, FutureMadeConcertsWeb.Endpoint,
  http: [port: 4002],
  server: false

config :FutureMadeConcerts,
  spotify_session: FutureMadeConcerts.Spotify.Session.Mock,
  spotify_client: FutureMadeConcerts.Spotify.Client.Mock

# Print only warnings and errors during test
config :logger, level: :warn

config :stream_data,
  max_runs: if(System.get_env("CI"), do: 20, else: 10)
