defmodule CreateFunWeb.PageController do
  use CreateFunWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def sitemap(conn, _) do
    urls = [
      CreateFunWeb.Router.Helpers.page_url(conn, :index),
    ]

    conn
      |> render("sitemap.txt", urls: urls)
  end

  def healthcheck(conn, _params) do
    # json(conn, %CreateFun.System.Healthcheck{
    #   application: :create_fun_web,
    #   application_version: CreateFunWeb.Mixfile.project[:version],
    #   current_url: current_path(conn),
    #   host: Plug.Conn.get_req_header(conn, "host")}
    # )
  end

end
