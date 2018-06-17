defmodule CreateFun.Accounts do
  import Ecto.Query, warn: false
  alias CreateFun.Repo
  alias CreateFun.Accounts.{Admin, Artist, User}

  # ------------
  # Admin
  # ------------

  def list_admins do
    Repo.all(Admin)
  end

  def get_admin!(id), do: Repo.get!(Admin, id)
  def get_admin(id), do: Repo.get(Admin, id)

  def get_admin_by(select), do: Repo.get_by(Admin, select)

  def create_admin(attrs \\ %{}) do
    %Admin{}
    |> Admin.changeset(attrs)
    |> Repo.insert()
  end

  def update_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.changeset(attrs)
    |> Repo.update()
  end

  def delete_admin(%Admin{} = admin) do
    Repo.delete(admin)
  end

  def change_admin(%Admin{} = admin) do
    Admin.changeset(admin, %{})
  end

  def reset_admin(%Admin{} = admin) do
    Admin.reset_changeset(admin, %{})
  end
  def reset_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.reset_changeset(attrs)
    |> Repo.update
  end

  # ------------
  # Artist
  # ------------

  def list_artists do
    Repo.all(Artist)
  end

  def get_artist!(id), do: Repo.get!(Artist, id)
  def get_artist(id), do: Repo.get(Artist, id)

  def get_artist_by(select), do: Repo.get_by(Artist, select)

  def create_artist(attrs \\ %{}) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> Repo.insert()
  end

  def update_artist(%Artist{} = artist, attrs) do
    artist
    |> Artist.changeset(attrs)
    |> Repo.update()
  end

  def delete_artist(%Artist{} = artist) do
    Repo.delete(artist)
  end

  def change_artist(%Artist{} = artist) do
    Artist.changeset(artist, %{})
  end

  def reset_artist(%Artist{} = artist) do
    Artist.reset_changeset(artist, %{})
  end
  def reset_artist(%Artist{} = artist, attrs) do
    artist
    |> Artist.reset_changeset(attrs)
    |> Repo.update
  end

  # ------------
  # User
  # ------------

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def identify_user(%User{} = user) do
    User.identify_changeset(user, %{})
  end
end
