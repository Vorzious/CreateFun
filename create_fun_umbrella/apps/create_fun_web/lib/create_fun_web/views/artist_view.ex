defmodule CreateFunWeb.ArtistView do
  use CreateFunWeb, :view

  def current_user(conn), do: Guardian.Plug.LoadResource.call(conn, [key: :artist]).private.guardian_artist_resource

  def get_image_gcs_url(item) do
  	CreateFun.GalleryImage.url({item.image, item})
  end
end
