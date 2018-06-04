defmodule CreateFun.GalleryTest do
  use CreateFun.DataCase

  alias CreateFun.Gallery

  describe "images" do
    alias CreateFun.Gallery.Image

    @valid_attrs %{art_style: "some art_style", artist_name: "some artist_name", child_friendly: true, description: "some description", image_url: "some image_url", rating: 42, title: "some title"}
    @update_attrs %{art_style: "some updated art_style", artist_name: "some updated artist_name", child_friendly: false, description: "some updated description", image_url: "some updated image_url", rating: 43, title: "some updated title"}
    @invalid_attrs %{art_style: nil, artist_name: nil, child_friendly: nil, description: nil, image_url: nil, rating: nil, title: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gallery.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Gallery.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Gallery.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Gallery.create_image(@valid_attrs)
      assert image.art_style == "some art_style"
      assert image.artist_name == "some artist_name"
      assert image.child_friendly == true
      assert image.description == "some description"
      assert image.image_url == "some image_url"
      assert image.rating == 42
      assert image.title == "some title"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gallery.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, image} = Gallery.update_image(image, @update_attrs)
      assert %Image{} = image
      assert image.art_style == "some updated art_style"
      assert image.artist_name == "some updated artist_name"
      assert image.child_friendly == false
      assert image.description == "some updated description"
      assert image.image_url == "some updated image_url"
      assert image.rating == 43
      assert image.title == "some updated title"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Gallery.update_image(image, @invalid_attrs)
      assert image == Gallery.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Gallery.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Gallery.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Gallery.change_image(image)
    end
  end
end
