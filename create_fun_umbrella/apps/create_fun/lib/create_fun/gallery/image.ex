defmodule CreateFun.Gallery.Image do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  use Arc.Ecto.Schema


  schema "images" do
    field :title, :string
    field :description, :string
    field :artist_name, :string
    field :art_style, :string
    field :rating, :integer
    field :rate_count, :integer, default: 0
    field :image, CreateFun.GalleryImage.Type
    field :child_friendly, :boolean, default: false
    field :approved, :boolean, default: false

    belongs_to :artist, CreateFun.Accounts.Artist

    timestamps()
  end

  @doc false
  def changeset(image, artist, attrs) do
    image
    |> cast(attrs, [:title, :artist_name, :child_friendly, :description, :rating, :rate_count, :art_style, :approved])
    |> put_assoc(:artist, artist)
    |> validate_required([:title, :child_friendly, :art_style])
  end

  def changeset_image(image, attrs) do
    image
    |> cast_attachments(attrs, [:image])
  end

  def changeset_approval(image, attrs) do
    image
    |> cast(attrs, [:approved])
  end

  def approved(query) do
    from im in query,
    where: im.approved == true
  end

  def child_friendly(query) do
    from im in query,
    where: im.child_friendly == true
  end

  def by_artist(query, id) do
    from im in query,
    where: im.artist_id == ^id
  end
end
