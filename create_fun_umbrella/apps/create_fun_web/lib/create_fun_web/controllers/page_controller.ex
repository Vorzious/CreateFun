defmodule CreateFunWeb.PageController do
  use CreateFunWeb, :controller

  defp current_user(conn), do: CreateFun.Guardian.Plug.current_resource(conn, key: :artist)

  def index(conn, _params) do
    case current_user(conn) do
      {:ok, user} ->
        conn
        |> redirect(to: page_path(conn, :dashboard))
      _ ->
        conn
        |> put_flash(:error, "Please login!")
        |> redirect(to: auth_path(conn, :index))
    end
  end

  def dashboard(conn, _) do
    images = CreateFun.Gallery.list_approved_images()
    
    conn
    |> render("dashboard.html", images: images)
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
