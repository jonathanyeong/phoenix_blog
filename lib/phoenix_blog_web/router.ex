defmodule PhoenixBlogWeb.Router do
  use PhoenixBlogWeb, :router

  import PhoenixBlogWeb.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixBlogWeb do
    pipe_through :browser

    get "/", PostController, :index
    resources "/posts", PostController, only: [:show, :index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixBlogWeb do
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
      live_dashboard "/dashboard", metrics: PhoenixBlogWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", PhoenixBlogWeb do
    pipe_through [:browser, :redirect_if_admin_is_authenticated]

    get "/admin/log_in", AdminSessionController, :new
    post "/admin/log_in", AdminSessionController, :create
    get "/admin/reset_password", AdminResetPasswordController, :new
    post "/admin/reset_password", AdminResetPasswordController, :create
    get "/admin/reset_password/:token", AdminResetPasswordController, :edit
    put "/admin/reset_password/:token", AdminResetPasswordController, :update
  end

  scope "/", PhoenixBlogWeb do
    pipe_through [:browser, :require_authenticated_admin]

    get "/admin", AdminDashboardController, :index
    get "/admin/settings", AdminSettingsController, :edit
    put "/admin/settings/update_password", AdminSettingsController, :update_password
    put "/admin/settings/update_email", AdminSettingsController, :update_email
    get "/admin/settings/confirm_email/:token", AdminSettingsController, :confirm_email
  end

  scope "/", PhoenixBlogWeb do
    pipe_through [:browser]

    delete "/admin/log_out", AdminSessionController, :delete
  end

  scope "/admin", PhoenixBlogWeb, as: :admin do
    pipe_through [:browser, :require_authenticated_admin]
    resources "/posts", PostController, except: [:index, :show]
  end
end
