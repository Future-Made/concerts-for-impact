defmodule FutureMadeConcertsWeb.LoggedOutTest do
  use FutureMadeConcertsWeb.ConnCase

  import Phoenix.LiveViewTest

  test "/ displays a login notice", %{conn: conn} do
    assert {:error, {:redirect, %{flash: _, to: "/auth/login"}}} = live(conn, "/")
  end

  test "/ with search params displays a login notice", %{conn: conn} do
    assert {:error, {:redirect, %{flash: _, to: "/auth/login"}}} = live(conn, "/?q=jethro+tull")
  end
end
