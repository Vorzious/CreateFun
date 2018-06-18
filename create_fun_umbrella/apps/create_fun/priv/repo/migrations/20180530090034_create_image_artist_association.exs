defmodule CreateFun.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :artist_id, references(:artists, on_delete: :delete_all)
    end
  end
end
