defmodule CreateFun.GalleryImage do
  use Arc.Definition
  use Arc.Ecto.Definition

  @extension_whitelist ~w(.jpg .jpeg .png .gif)
  @versions [:original]
  @acl :public_read

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end

  # To retain the original filename, but prefix the version and user id:
  def filename(_version, {file, scope}) do
    file_name = Path.basename(file.file_name, Path.extname(file.file_name))
    # "gallery_image_#{scope.id}_#{file_name}"
    "#{file_name}"
  end

  def __storage, do: Arc.Storage.GCS

  def gcs_object_headers(:original, {file, _scope}) do
    [content_type: MIME.from_path(file.file_name)]
  end
end
