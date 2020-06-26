defmodule PhoenixBlogWeb.AdminConfirmationController do
  use PhoenixBlogWeb, :controller

  alias PhoenixBlog.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"admin" => %{"email" => email}}) do
    if admin = Accounts.get_admin_by_email(email) do
      Accounts.deliver_admin_confirmation_instructions(
        admin,
        &Routes.admin_confirmation_url(conn, :confirm, &1)
      )
    end

    # Regardless of the outcome, show an impartial success/error message.
    conn
    |> put_flash(
      :info,
      "If your e-mail is in our system and it has not been confirmed yet, " <>
        "you will receive an e-mail with instructions shortly."
    )
    |> redirect(to: "/")
  end

  # Do not log in the admin after confirmation to avoid a
  # leaked token giving the admin access to the account.
  def confirm(conn, %{"token" => token}) do
    case Accounts.confirm_admin(token) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account confirmed successfully.")
        |> redirect(to: "/")

      :error ->
        conn
        |> put_flash(:error, "Confirmation link is invalid or it has expired.")
        |> redirect(to: "/")
    end
  end
end
