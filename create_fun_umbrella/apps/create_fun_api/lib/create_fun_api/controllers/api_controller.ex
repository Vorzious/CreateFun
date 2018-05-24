defmodule CreateFunApi.ApiController do
  use CreateFunApi, :controller

  def healthcheck(conn, _params) do
    json(conn, %CreateFun.System.Healthcheck{
          application: :create_fun_api,
          application_version: CreateFunApi.Mixfile.project[:version],
          current_url: current_path(conn),
          host: Plug.Conn.get_req_header(conn, "host")}
    )
  end
end
