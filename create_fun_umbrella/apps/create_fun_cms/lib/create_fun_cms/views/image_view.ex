defmodule CreateFunCms.ImageView do
  use CreateFunCms, :view

  def get_image_gcs_url(item) do
  	CreateFun.GalleryImage.url({item.image, item})
  end
end
