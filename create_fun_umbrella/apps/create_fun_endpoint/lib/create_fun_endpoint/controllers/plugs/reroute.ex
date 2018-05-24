defmodule CreateFunEndpoint.Reroute do
  import Plug.Conn

  def init(opts) do
    CreateFunApi.Router.init(opts) #YipYip-Scaffold-Remove-API
    CreateFunCms.Router.init(opts) #YipYip-Scaffold-Remove-CMS
    CreateFunWeb.Router.init(opts) #YipYip-Scaffold-Remove-WEB
  end

  def call(conn, params) do
    case conn.path_info do
      ["api" | _] -> CreateFunApi.Router.call(conn, params) #YipYip-Scaffold-Remove-API
      ["cms" | _] -> CreateFunCms.Router.call(conn, params) #YipYip-Scaffold-Remove-CMS
      _ -> CreateFunWeb.Router.call(conn, params) #YipYip-Scaffold-Remove-WEB
    end
  end
end
