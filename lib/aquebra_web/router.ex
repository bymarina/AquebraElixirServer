defmodule AquebraWeb.Router do
  use AquebraWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AquebraWeb.LayoutView, :root}
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AquebraWeb do
    #    pipe_through :browser
    #    get "/", PageController, :index

    scope "/api" do
      pipe_through :api
      resources "/address", AddressController
      resources "/document", DocumentController
      resources "/donation_match", DonationMatchController
      resources "/donation_product", DonationProductController
      resources "/donor_entity", DonorEntityController
      resources "/donor_entity_donation", DonorEntityDonationController
      resources "/needed_donation", NeededDonationController
      resources "/receiving_entity", ReceivingEntityController
      resources "/town_hall_user", TownHallUserController
      resources "/user", UserController
      resources "/volunteer", VolunteerController
      resources "/page", PageController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", AquebraWeb do
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

      live_dashboard "/dashboard", metrics: AquebraWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
