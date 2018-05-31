defmodule CreateFunWeb.Auth.ErrorHandler do
  use CreateFunWeb, :controller
  # import Plug.Conn

  alias CreateFun.Guardian

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> Guardian.Plug.sign_out([key: :artist])
    # |> configure_session(drop: true)
    |> redirect(to: auth_path(conn, :index))
    |> Plug.Conn.halt()
  end
end
