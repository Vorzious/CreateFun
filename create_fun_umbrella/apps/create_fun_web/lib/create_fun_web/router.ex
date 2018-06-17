defmodule CreateFunWeb.Router do
  use CreateFunWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth_access do
    plug CreateFunWeb.Auth.Pipeline.Access
  end

  pipeline :auth_auth do
    plug CreateFunWeb.Auth.Pipeline.Auth
  end

  scope "/", CreateFunWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/artist", ArtistController, only: [:new, :create]
    get "/sitemap.txt", PageController, :sitemap
    get "/healthcheck", PageController, :healthcheck

    # Authentication Zone
    scope "/auth" do
      pipe_through [:auth_auth]
      # TODO
      # Add artist

      get "/", AuthController, :index
      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
      post "/:provider/callback", AuthController, :callback
      delete "/logout", AuthController, :delete

      get "/identity/identify", AuthController, :identify
      post "/identity/identify", AuthController, :identify_callback
      get "/identity/reset", AuthController, :reset
      put "/identity/reset", AuthController, :reset_callback
      patch "/identity/reset", AuthController, :reset_callback
    end

    # Authenticated Zone
    scope "/" do
      pipe_through [:auth_access]

      get "/dashboard", PageController, :dashboard
      resources "/artist", ArtistController, only: [:index, :edit, :update, :delete, :show]
      resources "/art", ImageController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CreateFunWeb do
  #   pipe_through :api
  # end
end
