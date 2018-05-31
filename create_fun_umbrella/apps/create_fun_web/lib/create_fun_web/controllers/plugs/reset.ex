defmodule CreateFunWeb.Plug.Reset do
  import Plug.Conn
  import Guardian.Plug.Keys
  alias Guardian.Plug.Pipeline
  alias CreateFun.Guardian

  @default_token_location "token"

  def init(opts), do: opts

  def call(conn, opts) do
    conn
    |> Guardian.Plug.sign_out([key: :artist])
    |> Guardian.Plug.sign_out([key: :reset])
    |> put_token_in_session(opts)
  end

  defp put_token_in_session(conn, opts) do
    key = conn |> storage_key(opts) |> token_key()
    token = find_token(conn, opts)
    if token do
      conn
      |> put_session(key, token)
    else
      return_error(conn, :no_token_found, opts)
    end
  end

  defp find_token(conn, opts) do
    token_location = Keyword.get(opts, :token_location, @default_token_location)
    conn.params[token_location]
  end

  defp storage_key(conn, opts), do: Pipeline.fetch_key(conn, opts)

  defp return_error(conn, reason, opts) do
    handler = Pipeline.fetch_error_handler!(conn, opts)
    conn = apply(handler, :auth_error, [conn, {:no_token_found, reason}, opts])
    halt(conn)
  end
end
