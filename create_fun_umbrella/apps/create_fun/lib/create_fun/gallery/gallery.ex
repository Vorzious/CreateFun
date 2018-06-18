defmodule CreateFun.Gallery do
  @moduledoc """
  The Gallery context.
  """

  import Ecto.Query, warn: false
  alias CreateFun.Repo
  alias Ecto.Multi

  alias CreateFun.Gallery.Image

  def list_images do
    Repo.all(Image)
  end

  def list_approved_images() do
    Image
    |> Image.approved()
    |> Repo.all()
  end

  def list_approved_images_by_artist(id) do
    Image
    |> Image.approved()
    |> Image.by_artist(id)
    |> Repo.all()
  end

  def get_image!(id), do: Repo.get!(Image, id)
  def get_image(id), do: Repo.get(Image, id)

  def create_image(artist, attrs \\ %{}) do
    Multi.new
    |> Multi.insert(:insert_image, Image.changeset(%Image{}, artist, attrs))
    |> Multi.run(:set_image, fn %{insert_image: image} ->
      if(image.id) do
        image
        |> Image.changeset_image(attrs)
        |> CreateFun.Repo.update()
      else
        {:ok, image}
      end
    end)
    |> Repo.transaction()
  end

  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Image.changeset_image(attrs)
    |> Repo.update()
  end

  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  def change_image(%Image{} = image) do
    Image.changeset(image, %{})
  end

  def update_image_approval(image, status) do
    image
    |> Image.changeset_approval(status)
    |> Repo.update()
  end
end
