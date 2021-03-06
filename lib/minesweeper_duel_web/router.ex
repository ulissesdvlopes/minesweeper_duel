defmodule MinesweeperDuelWeb.Router do
  use MinesweeperDuelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MinesweeperDuelWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MinesweeperDuelWeb do
    pipe_through :browser

    get "/", MinesweeperController, :index
    post "/game-ms", MinesweeperController, :create
    get "/game-ms/:id", MinesweeperController, :live
    get "/game-ms/:id/enter", MinesweeperController, :enter
    post "/game-ms/:id/enter", MinesweeperController, :create_session
  end

  # Other scopes may use custom stacks.
  # scope "/api", MinesweeperDuelWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MinesweeperDuelWeb.Telemetry
    end
  end
end
