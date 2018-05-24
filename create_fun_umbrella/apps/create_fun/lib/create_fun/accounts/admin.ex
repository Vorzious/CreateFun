defmodule CreateFun.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset


  schema "admins" do
    field :username, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end
  use CreateFun.Accounts.User

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:username, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> put_pass_hash()
    |> validate_required([:username, :encrypted_password])
    |> unique_constraint(:username)
  end
end
