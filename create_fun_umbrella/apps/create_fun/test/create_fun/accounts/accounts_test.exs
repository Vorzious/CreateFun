defmodule CreateFun.AccountsTest do
  use CreateFun.DataCase

  alias CreateFun.Accounts

  describe "admins" do
    alias CreateFun.Accounts.Admin

    @valid_attrs %{encrypted_password: "some encrypted_password", username: "some username"}
    @update_attrs %{encrypted_password: "some updated encrypted_password", username: "some updated username"}
    @invalid_attrs %{encrypted_password: nil, username: nil}

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_admin()

      admin
    end

    test "list_admins/0 returns all admins" do
      admin = admin_fixture()
      assert Accounts.list_admins() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Accounts.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Accounts.create_admin(@valid_attrs)
      assert admin.encrypted_password == "some encrypted_password"
      assert admin.username == "some username"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, admin} = Accounts.update_admin(admin, @update_attrs)
      assert %Admin{} = admin
      assert admin.encrypted_password == "some updated encrypted_password"
      assert admin.username == "some updated username"
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_admin(admin, @invalid_attrs)
      assert admin == Accounts.get_admin!(admin.id)
    end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Accounts.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_admin!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Accounts.change_admin(admin)
    end
  end

  describe "artists" do
    alias CreateFun.Accounts.Artist

    @valid_attrs %{art_style: "some art_style", email: "some email", encrypted_password: "some encrypted_password", first_name: "some first_name", last_name: "some last_name", phone: "some phone", username: "some username", website: "some website"}
    @update_attrs %{art_style: "some updated art_style", email: "some updated email", encrypted_password: "some updated encrypted_password", first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone", username: "some updated username", website: "some updated website"}
    @invalid_attrs %{art_style: nil, email: nil, encrypted_password: nil, first_name: nil, last_name: nil, phone: nil, username: nil, website: nil}

    def artist_fixture(attrs \\ %{}) do
      {:ok, artist} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_artist()

      artist
    end

    test "list_artists/0 returns all artists" do
      artist = artist_fixture()
      assert Accounts.list_artists() == [artist]
    end

    test "get_artist!/1 returns the artist with given id" do
      artist = artist_fixture()
      assert Accounts.get_artist!(artist.id) == artist
    end

    test "create_artist/1 with valid data creates a artist" do
      assert {:ok, %Artist{} = artist} = Accounts.create_artist(@valid_attrs)
      assert artist.art_style == "some art_style"
      assert artist.email == "some email"
      assert artist.encrypted_password == "some encrypted_password"
      assert artist.first_name == "some first_name"
      assert artist.last_name == "some last_name"
      assert artist.phone == "some phone"
      assert artist.username == "some username"
      assert artist.website == "some website"
    end

    test "create_artist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_artist(@invalid_attrs)
    end

    test "update_artist/2 with valid data updates the artist" do
      artist = artist_fixture()
      assert {:ok, artist} = Accounts.update_artist(artist, @update_attrs)
      assert %Artist{} = artist
      assert artist.art_style == "some updated art_style"
      assert artist.email == "some updated email"
      assert artist.encrypted_password == "some updated encrypted_password"
      assert artist.first_name == "some updated first_name"
      assert artist.last_name == "some updated last_name"
      assert artist.phone == "some updated phone"
      assert artist.username == "some updated username"
      assert artist.website == "some updated website"
    end

    test "update_artist/2 with invalid data returns error changeset" do
      artist = artist_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_artist(artist, @invalid_attrs)
      assert artist == Accounts.get_artist!(artist.id)
    end

    test "delete_artist/1 deletes the artist" do
      artist = artist_fixture()
      assert {:ok, %Artist{}} = Accounts.delete_artist(artist)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_artist!(artist.id) end
    end

    test "change_artist/1 returns a artist changeset" do
      artist = artist_fixture()
      assert %Ecto.Changeset{} = Accounts.change_artist(artist)
    end
  end
end
