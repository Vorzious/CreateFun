defmodule CreateFunCms.ArtistController do
  use CreateFunCms, :controller

  alias CreateFun.Accounts
  alias CreateFun.Accounts.Artist

  def index(conn, _params) do
    artists = Accounts.list_artists()
    render(conn, "index.html", artists: artists)
  end

  def new(conn, _params) do
    changeset = Accounts.change_artist(%Artist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"artist" => artist_params}) do
    artist = CreateFun.Guardian.Plug.current_resource(conn, key: :artist) 

    case Accounts.create_artist(artist, artist_params) do
      {:ok, artist} ->
        conn
        |> put_flash(:info, "Artist created successfully.")
        |> redirect(to: artist_path(conn, :show, artist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    artist = Accounts.get_artist!(id)
    render(conn, "show.html", artist: artist)
  end

  def edit(conn, %{"id" => id}) do
    artist = Accounts.get_artist!(id)
    changeset = Accounts.change_artist(artist)
    render(conn, "edit.html", artist: artist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "artist" => artist_params}) do
    artist = Accounts.get_artist!(id)

    case Accounts.update_artist(artist, artist_params) do
      {:ok, artist} ->
        conn
        |> put_flash(:info, "Artist updated successfully.")
        |> redirect(to: artist_path(conn, :show, artist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", artist: artist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    artist = Accounts.get_artist!(id)
    {:ok, _artist} = Accounts.delete_artist(artist)

    conn
    |> put_flash(:info, "Artist deleted successfully.")
    |> redirect(to: artist_path(conn, :index))
  end
end
