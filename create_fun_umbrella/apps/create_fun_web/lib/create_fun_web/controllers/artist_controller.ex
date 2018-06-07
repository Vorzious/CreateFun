defmodule CreateFunWeb.ArtistController do
  use CreateFunWeb, :controller

  alias CreateFun.Accounts
  alias CreateFun.Accounts.Artist

  def index(conn, _) do
    artists = Accounts.list_artists()

    conn
    |> render("index.html", artists: artists)
  end

  def new(conn, _params) do
    changeset = Accounts.change_artist(%Artist{})
    conn
    |> put_layout("login.html")
    |> render("new.html", changeset: changeset)
    # render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"artist" => artist_params}) do
    case Accounts.create_artist(artist_params) do
      {:ok, artist} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: auth_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_layout("login.html")
        |> render("new.html", changeset: changeset)
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
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: artist_path(conn, :show, artist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", artist: artist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    artist = Accounts.get_artist!(id)
    {:ok, _artist} = Accounts.delete_artist(artist)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
