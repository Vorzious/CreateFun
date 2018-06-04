defmodule CreateFun.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias CreateFun.Accounts.{User}
  alias CreateFun.Repo
  alias Ueberauth.Auth

  embedded_schema do
    field :username
    field :password
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
  end

  def identify_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end

  @callback put_pass_hash(Ecto.Changeset.t) :: Ecto.Changeset.t
  @callback validate_login(Ueberauth.Auth.t, module()) :: {:ok, struct()} | {:error, String.t}
  @callback reset_changeset(Ecto.Schema.t(), [String.t() | atom()]) :: Ecto.Changeset.t

  @doc """
  Inject code in modules that have `use CreateFun.Accounts.User`
  """
  defmacro __using__(opts) do
    quote location: :keep do
      @behaviour CreateFun.Accounts.User
      @opts unquote(opts)

      @doc false
      def put_pass_hash(%Ecto.Changeset{valid?: true, changes:
                                        %{password: password}} = changeset) do
        change(changeset, Comeonin.Argon2.add_hash(password, [hash_key: :encrypted_password]))
      end
      def put_pass_hash(changeset), do: changeset

      def validate_login(%Auth{} = auth, schema \\ __MODULE__) do
        Repo.get_by(schema, username: auth.uid)
        |> Comeonin.Argon2.check_pass(auth.credentials.other.password)
      end

      def reset_changeset(%__MODULE__{} = resource, attrs) do
        resource
        |> cast(attrs, [:password, :password_confirmation])
        |> validate_confirmation(:password)
        |> put_pass_hash()
        |> validate_required([:encrypted_password])
      end

      defoverridable CreateFun.Accounts.User
    end
  end
end
