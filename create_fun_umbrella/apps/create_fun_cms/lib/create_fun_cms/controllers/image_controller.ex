defmodule CreateFunCms.ImageController do
  use CreateFunCms, :controller

  alias CreateFun.Gallery
  alias CreateFun.Gallery.Image

  def index(conn, _params) do
    images = Gallery.list_images()
    render(conn, "index.html", images: images)
  end

  def new(conn, _params) do
    changeset = Gallery.change_image(%Image{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    case Gallery.create_image(image_params) do
      {:ok, %{insert_image: image}} ->
        conn
        |> put_flash(:info, "Image added successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, _failed_operation, %Ecto.Changeset{} = changeset, _changes_so_far} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Gallery.get_image!(id)
    render(conn, "show.html", image: image)
  end

  def edit(conn, %{"id" => id}) do
    image = Gallery.get_image!(id)
    changeset = Gallery.change_image(image)
    render(conn, "edit.html", image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Gallery.get_image!(id)

    case Gallery.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: image_path(conn, :show, image))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Gallery.get_image!(id)
    {:ok, _image} = Gallery.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: image_path(conn, :index))
  end

  def approve(conn, %{"id" => id}) do
    image = Gallery.get_image!(id)

    case (Gallery.update_image_approval(image, %{"approved" => true})) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image has been approved and will be shown to the public")
        |> redirect(to: image_path(conn, :show, image))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Something went wrong when trying to approve this image.")
        |> redirect(to: image_path(conn, :show, image))
    end
  end

  def unapprove(conn, %{"id" => id}) do
    image = Gallery.get_image!(id)

    case (Gallery.update_image_approval(image, %{"approved" => false})) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image has been unapproved and will no longer be shown to the public")
        |> redirect(to: image_path(conn, :show, image))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Something went wrong when trying to unapprove this image.")
        |> redirect(to: image_path(conn, :show, image))
    end
  end
end
