defmodule CreateFunCms.Router do
  use CreateFunCms, :router

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

  # Guest Zone
  scope "/cms/", CreateFunCms do
    pipe_through [:browser] # Use the default browser stack

    scope "/" do
      get "/", PageController, :index
      get "/healthcheck", PageController, :healthcheck
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CreateFunCms do
  #   pipe_through :api
  # end
end
