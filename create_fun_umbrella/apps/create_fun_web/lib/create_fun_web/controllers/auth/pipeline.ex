defmodule CreateFunWeb.Auth.Pipeline do

  defmodule Access do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_web

    plug Guardian.Plug.VerifySession, [claims: %{"typ" => "access"}, key: :artist]
    plug Guardian.Plug.VerifyHeader, [claims: %{"typ" => "access"}, key: :artist]
    plug Guardian.Plug.EnsureAuthenticated, [key: :artist]
    plug Guardian.Plug.LoadResource, [allow_blank: false, key: :artist]
  end

  defmodule Auth do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_web
  end

  defmodule Reset do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_web

    plug CreateFunWeb.Plug.Reset, [key: :reset]
    plug Guardian.Plug.VerifySession, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.VerifyHeader, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.EnsureAuthenticated, [key: :reset]
    plug Guardian.Plug.LoadResource, [allow_blank: false, key: :reset]
  end

  defmodule ResetCallback do
    use Guardian.Plug.Pipeline, otp_app: :create_fun_web

    plug Guardian.Plug.VerifySession, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.VerifyHeader, [claims: %{"typ" => "reset"}, key: :reset]
    plug Guardian.Plug.EnsureAuthenticated, [key: :reset]
    plug Guardian.Plug.LoadResource, [allow_blank: false, key: :reset]
  end
end
