defmodule CreateFun.Accounts.Artist do
  use Ecto.Schema
  import Ecto.Changeset


  schema "artists" do
    field :username, :string
    field :encrypted_password, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :website, :string
    field :art_style, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end
  use CreateFun.Accounts.User

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:username, :password, :password_confirmation, :art_style, :first_name, :last_name, :email, :website, :phone])
    |> validate_confirmation(:password)
    |> put_pass_hash()
    |> validate_required([:username, :encrypted_password])
    |> validate_format(:email, ~r|@|)
    |> unique_constraint(:username)
  end
end
