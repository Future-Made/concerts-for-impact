defmodule FutureMadeConcertsWeb.Router do
  @moduledoc false
  use FutureMadeConcertsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FutureMadeConcertsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :admin_auth
  end

  import FutureMadeConcertsWeb.AuthController, only: [ensure_authenticated: 2]

  pipeline :authenticated do
    plug :ensure_authenticated
  end

  scope "/auth", FutureMadeConcertsWeb do
    pipe_through :browser

    get "/login", AuthController, :new
    get "/logout", AuthController, :delete
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    post "/logout", AuthController, :delete
  end

  scope "/", FutureMadeConcertsWeb do
    pipe_through [:browser, :authenticated]

    live "/", ExplorerLive, :suggestions
    live "/search", ExplorerLive, :search
    live "/artists/:artist_id", ExplorerLive, :artist_details
    live "/albums/:album_id", ExplorerLive, :album_details
    live "/shows/:show_id", ExplorerLive, :show_details
    live "/episodes/:episode_id", ExplorerLive, :episode_details

    resources "/non_gov_orgs", NonGovOrgController
    resources "/broadcasters", BroadcasterController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FutureMadeConcertsWeb do
  #   pipe_through :api
  # end

  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through [:admin, :browser]

    live_dashboard "/dashboard",
      metrics: FutureMadeConcertsWeb.Telemetry,
      metrics_history: {FutureMadeConcertsWeb.Telemetry.Storage, :metrics_history, []},
      additional_pages: [
        spotify_sessions: FutureMadeConcertsWeb.LiveDashboard.SpotifySessionsPage
      ]
  end

  defp admin_auth(conn, _opts) do
    with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn),
         admin_user <- FutureMadeConcertsWeb.Endpoint.config(:admin_user),
         admin_pass <- FutureMadeConcertsWeb.Endpoint.config(:admin_password),
         true <- Plug.Crypto.secure_compare(user, admin_user),
         true <- Plug.Crypto.secure_compare(pass, admin_pass) do
      conn
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end
end
