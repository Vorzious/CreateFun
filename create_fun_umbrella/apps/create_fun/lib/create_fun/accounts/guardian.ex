defmodule CreateFun.Guardian do
  use Guardian, otp_app: :create_fun
  use Guardian.Permissions.Bitwise

  alias CreateFun.Accounts.{Admin, Artist}
  alias CreateFun.Repo

  @whitelisted_resources [Admin, Artist]

  def subject_for_token(%_{} = resource, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    struct = resource.__struct__
    cond do
      !Enum.member?(@whitelisted_resources, struct) -> {:error, :unsupported_resource}
      is_nil(resource.id) -> {:error, :invalid_resource}
      true ->
        sub = to_string(struct) <> ":" <> to_string(resource.id)
        {:ok, sub}
    end
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => sub}) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    [string_module, string_id] = sub |> String.split(":", [parts: 2, trim: true])

    module = String.to_atom(string_module)
    parsed_id = Integer.parse(string_id)
    cond do
      !Enum.member?(@whitelisted_resources, module) -> {:error, :unsupported_resource}
      {id, ""} = parsed_id ->
        case Repo.get(module, id) do
          %^module{} = resource-> {:ok, resource}
          nil -> {:error, :not_found}
        end
      true -> {:error, :invalid_data}
    end
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def build_claims(claims, _resource, opts) do
    claims = claims
    |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))

    {:ok, claims}
  end

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

end
