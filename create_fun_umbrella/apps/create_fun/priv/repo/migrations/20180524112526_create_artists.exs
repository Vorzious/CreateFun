defmodule CreateFun.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :username, :string
      add :encrypted_password, :string
      add :art_style, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :website, :string
      add :phone, :string

      timestamps()
    end
    create unique_index(:artists, [:username])

  end
end
