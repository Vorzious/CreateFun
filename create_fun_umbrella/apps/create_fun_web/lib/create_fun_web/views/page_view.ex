defmodule CreateFunWeb.PageView do
  use CreateFunWeb, :view

  def get_image_gcs_url(item) do
  	CreateFun.GalleryImage.url({item.image, item})
  end
end
