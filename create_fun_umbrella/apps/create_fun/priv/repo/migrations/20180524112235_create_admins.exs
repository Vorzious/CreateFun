defmodule CreateFun.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :username, :string
      add :encrypted_password, :string

      timestamps()
    end
    create unique_index(:admins, [:username])

  end
end
