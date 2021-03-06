defmodule PhoenixBlogWeb.AdminSessionControllerTest do
  use PhoenixBlogWeb.ConnCase, async: true

  import PhoenixBlog.AccountsFixtures

  setup do
    %{admin: admin_fixture()}
  end

  describe "GET /admins/log_in" do
    test "renders log in page", %{conn: conn} do
      conn = get(conn, Routes.admin_session_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>Log in</h1>"
      assert response =~ "Log in</a>"
    end

    test "redirects if already logged in", %{conn: conn, admin: admin} do
      conn = conn |> log_in_admin(admin) |> get(Routes.admin_session_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /admins/log_in" do
    test "logs the admin in with remember me", %{conn: conn, admin: admin} do
      conn =
        post(conn, Routes.admin_session_path(conn, :create), %{
          "admin" => %{
            "email" => admin.email,
            "password" => valid_admin_password(),
            "remember_me" => "true"
          }
        })

      assert conn.resp_cookies["admin_remember_me"]
      assert redirected_to(conn) =~ "/"
    end

    test "emits error message with invalid credentials", %{conn: conn, admin: admin} do
      conn =
        post(conn, Routes.admin_session_path(conn, :create), %{
          "admin" => %{"email" => admin.email, "password" => "invalid_password"}
        })

      response = html_response(conn, 200)
      assert response =~ "<h1>Log in</h1>"
      assert response =~ "Invalid e-mail or password"
    end
  end

  describe "DELETE /admins/log_out" do
    test "logs the admin out", %{conn: conn, admin: admin} do
      conn = conn |> log_in_admin(admin) |> delete(Routes.admin_session_path(conn, :delete))
      assert redirected_to(conn) == "/"
      refute get_session(conn, :admin_token)
      assert get_flash(conn, :info) =~ "Logged out successfully"
    end

    test "succeeds even if the admin is not logged in", %{conn: conn} do
      conn = delete(conn, Routes.admin_session_path(conn, :delete))
      assert redirected_to(conn) == "/"
      refute get_session(conn, :admin_token)
      assert get_flash(conn, :info) =~ "Logged out successfully"
    end
  end
end
