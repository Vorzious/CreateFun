defmodule CreateFunWeb.LayoutView do
  use CreateFunWeb, :view

  def current_user(conn), do: Guardian.Plug.LoadResource.call(conn, [key: :artist]).private.guardian_artist_resource
end
