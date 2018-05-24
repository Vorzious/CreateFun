defmodule CreateFunCms.PageController do
  use CreateFunCms, :controller

  def index(conn, _params) do
    conn |> redirect(to: page_path(conn, :dashboard))
  end

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end

  def login(conn, _params) do
    render conn, "login.html", layout: {CreateFunCms.LayoutView, "login.html"}
  end
  
  def forgot_pass(conn, _params) do
    render conn, "forgot_pass.html", layout: {CreateFunCms.LayoutView, "login.html"}
  end

  def healthcheck(conn, _params) do
    # json(conn, %CreateFun.System.Healthcheck{
    #   application: :create_fun_cms,
    #   application_version: CreateFunCms.Mixfile.project[:version],
    #   current_url: current_path(conn),
    #   host: Plug.Conn.get_req_header(conn, "host")}
    # )
  end

end
