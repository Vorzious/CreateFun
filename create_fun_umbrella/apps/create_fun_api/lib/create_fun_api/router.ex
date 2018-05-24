defmodule CreateFunApi.Router do
  use CreateFunApi, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CreateFunApi do
    pipe_through :api

    get "/healthcheck", ApiController, :healthcheck
  end
end
