defmodule AusbildungsnachweisdigitalWeb.Router do
  use AusbildungsnachweisdigitalWeb, :router

  import AusbildungsnachweisdigitalWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {AusbildungsnachweisdigitalWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", AusbildungsnachweisdigitalWeb do
    pipe_through(:browser)

    get("/", PageController, :home)
  end

  # Other scopes may use custom stacks.
  # scope "/api", AusbildungsnachweisdigitalWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ausbildungsnachweisdigital, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: AusbildungsnachweisdigitalWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", AusbildungsnachweisdigitalWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{AusbildungsnachweisdigitalWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live("/users/register", UserRegistrationLive, :new)
      live("/users/log_in", UserLoginLive, :new)
      live("/users/reset_password", UserForgotPasswordLive, :new)
      live("/users/reset_password/:token", UserResetPasswordLive, :edit)
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", AusbildungsnachweisdigitalWeb do
    pipe_through([:browser, :require_authenticated_user])

    live_session :require_authenticated_user,
      on_mount: [{AusbildungsnachweisdigitalWeb.UserAuth, :ensure_authenticated}] do
      live("/users/settings", UserSettingsLive, :edit)
      live("/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email)

      live("/reports", ReportLive.Index, :index)
      live("/reports/new", ReportLive.Index, :new)
      live("/reports/:id/edit", ReportLive.Index, :edit)

      live("/reports/:id", ReportLive.Show, :show)
      live("/reports/:id/show/edit", ReportLive.Show, :edit)

      live "/goals", GoalLive.Index, :index
      live "/goals/new", GoalLive.Index, :new
      live "/goals/:id/edit", GoalLive.Index, :edit

      live "/goals/:id", GoalLive.Show, :show
      live "/goals/:id/show/edit", GoalLive.Show, :edit
    end
  end

  scope "/", AusbildungsnachweisdigitalWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)

    live_session :current_user,
      on_mount: [{AusbildungsnachweisdigitalWeb.UserAuth, :mount_current_user}] do
      live("/users/confirm/:token", UserConfirmationLive, :edit)
      live("/users/confirm", UserConfirmationInstructionsLive, :new)
    end
  end
end
