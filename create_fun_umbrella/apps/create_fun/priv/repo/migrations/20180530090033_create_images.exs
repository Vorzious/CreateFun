defmodule CreateFun.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :title, :string
      add :artist_name, :string
      add :child_friendly, :boolean, default: false, null: false
      add :approved, :boolean, default: false, null: false
      add :image, :string
      add :description, :text
      add :rating, :integer
      add :rate_count, :integer, default: 0
      add :art_style, :string

      timestamps()
    end
  end
end
