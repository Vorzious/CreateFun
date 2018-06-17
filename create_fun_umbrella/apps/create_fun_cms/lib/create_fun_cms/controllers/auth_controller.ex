defmodule CreateFunCms.AuthController do
  use CreateFunCms, :controller

  alias Ueberauth.Strategy.Helpers
  alias Guardian.Plug, as: GPlug
  alias Guardian.Permissions.Bitwise, as: GPermissions
  alias CreateFun.{Accounts, Guardian}
  alias CreateFun.Accounts.{User, Admin}
  import Phoenix.View, only: [render_to_string: 3]

  plug Ueberauth
  plug :put_layout, "login.html"
  plug GPlug.EnsureNotAuthenticated, [key: :admin] when action in [:index, :request, :callback, :identify, :identify_callback, :reset_callback]
  plug CreateFunCms.Auth.Pipeline.Reset when action in [:reset]
  plug CreateFunCms.Auth.Pipeline.ResetCallback when action in [:reset_callback]

  def index(conn, _params) do
    conn
    |> redirect(to: auth_path(conn, :request, "identity"))
  end

  def request(conn, %{"provider" => "identity"}) do
    render(conn, "request.html",
      action: Helpers.callback_url(conn),
      changeset: Accounts.change_user(%User{}))
  end
  def request(conn, _params) do
    conn
    |> put_status(:not_found)
    |> put_view(CreateFunCms.ErrorView)
    |> render("404.html")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> Guardian.Plug.sign_out([key: :admin])
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: auth_path(conn, :index))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: auth_path(conn, :index))
  end
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Admin.validate_login(auth) do
      {:ok, %Admin{} = resource} ->
        conn
        |> Guardian.Plug.sign_in(resource, %{}, [key: :admin, permissions: %{admin: GPermissions.max()}])
        |> put_flash(:info, "Successfully authenticated.")
        |> redirect(to: page_path(conn, :dashboard))
      {:error, _message} ->
        conn
        |> put_flash(:error, "Failed to authenticate.")
        |> redirect(to: auth_path(conn, :index))
    end
  end

  def identify(conn, _params) do
    render(conn, "identify.html",
      action: auth_path(conn, :identify_callback),
      changeset: Accounts.identify_user(%User{}))
  end

  def identify_callback(conn, %{"user" => user_params}) do
    # guardian_opts = [ttl: {3, :hours}, token_type: "reset", permissions: %{admin: [:password]}]
    # with %Admin{} = admin <- Accounts.get_admin_by(username: user_params["username"]),
    #      {:ok, token, _} <- CreateFun.Guardian.encode_and_sign(admin, %{}, guardian_opts)
          #  mail_opts = [salutation: Human.salutation(admin), token: token, layout: {CreateFunCms.LayoutView, "mail.html"}],
          #  html = render_to_string(MailView, "admin_reset.html", mail_opts),
          #  txt = render_to_string(MailView, "admin_reset.txt", Keyword.delete(mail_opts, :layout)),
          #  %Aws.Ses{} = email <- Aws.Ses.build_email(admin, "CreateFun Administrator password reset!", html, txt),
        #  {:ok, _} <- email |> Aws.Ses.send_email() do
    #   conn
    #   |> put_flash(:info, "We sent you an email.")
    #   |> redirect(to: auth_path(conn, :index))
    # else
    #   _ ->
    #     conn
    #     |> put_flash(:error, "Something went wrong, we couldn't send a reset link.")
    #     |> redirect(to: auth_path(conn, :identify))
    # end
  end

  def reset(conn, _params) do
    admin = Guardian.Plug.current_resource(conn, [key: :reset])
    render(conn, "reset.html",
      action: auth_path(conn, :reset_callback),
      changeset: Accounts.reset_admin(admin))
  end

  def reset_callback(conn, %{"admin" => user_params}) do
    admin = Guardian.Plug.current_resource(conn, [key: :reset])
    case Accounts.reset_admin(admin, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully updated")
        |> redirect(to: auth_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong.")
        |> redirect(to: auth_path(conn, :index))
    end
  end

end
