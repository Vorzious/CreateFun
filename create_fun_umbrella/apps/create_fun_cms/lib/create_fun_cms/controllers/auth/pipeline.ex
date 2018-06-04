defmodule CreateFunCms.Auth.Pipeline do

  defmodule Access do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_cms

    plug Guardian.Plug.VerifySession, [claims: %{"typ" => "access"}, key: :admin]
    plug Guardian.Plug.VerifyHeader, [claims: %{"typ" => "access"}, key: :admin]
    plug Guardian.Plug.EnsureAuthenticated, [key: :admin]
    plug Guardian.Plug.LoadResource, [allow_blank: false, key: :admin]
  end

  defmodule Auth do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_cms
  end

  defmodule Reset do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_cms

    plug CreateFunCms.Plug.Reset, [key: :reset]
    plug Guardian.Plug.VerifySession, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.VerifyHeader, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.EnsureAuthenticated, [key: :reset]
    plug Guardian.Plug.LoadResource, [allow_blank: false, key: :reset]
  end

  defmodule ResetCallback do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_cms

    plug Guardian.Plug.VerifySession, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.VerifyHeader, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.EnsureAuthenticated, [key: :reset]
    plug Guardian.Plug.LoadResource, [allow_blank: false, key: :reset]
  end
end
