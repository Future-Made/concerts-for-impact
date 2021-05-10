defmodule FutureMadeConcertsWeb.BroadcasterControllerTest do
  use FutureMadeConcertsWeb.ConnCase

  alias FutureMadeConcerts.Profiles

  @create_attrs %{city: "some city", country: "some country", description: "some description", follower_count: 42, name: "some name"}
  @update_attrs %{city: "some updated city", country: "some updated country", description: "some updated description", follower_count: 43, name: "some updated name"}
  @invalid_attrs %{city: nil, country: nil, description: nil, follower_count: nil, name: nil}

  def fixture(:broadcaster) do
    {:ok, broadcaster} = Profiles.create_broadcaster(@create_attrs)
    broadcaster
  end

  describe "index" do
    test "lists all broadcasters", %{conn: conn} do
      conn = get(conn, Routes.broadcaster_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Broadcasters"
    end
  end

  describe "new broadcaster" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.broadcaster_path(conn, :new))
      assert html_response(conn, 200) =~ "New Broadcaster"
    end
  end

  describe "create broadcaster" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.broadcaster_path(conn, :create), broadcaster: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.broadcaster_path(conn, :show, id)

      conn = get(conn, Routes.broadcaster_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Broadcaster"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.broadcaster_path(conn, :create), broadcaster: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Broadcaster"
    end
  end

  describe "edit broadcaster" do
    setup [:create_broadcaster]

    test "renders form for editing chosen broadcaster", %{conn: conn, broadcaster: broadcaster} do
      conn = get(conn, Routes.broadcaster_path(conn, :edit, broadcaster))
      assert html_response(conn, 200) =~ "Edit Broadcaster"
    end
  end

  describe "update broadcaster" do
    setup [:create_broadcaster]

    test "redirects when data is valid", %{conn: conn, broadcaster: broadcaster} do
      conn = put(conn, Routes.broadcaster_path(conn, :update, broadcaster), broadcaster: @update_attrs)
      assert redirected_to(conn) == Routes.broadcaster_path(conn, :show, broadcaster)

      conn = get(conn, Routes.broadcaster_path(conn, :show, broadcaster))
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, broadcaster: broadcaster} do
      conn = put(conn, Routes.broadcaster_path(conn, :update, broadcaster), broadcaster: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Broadcaster"
    end
  end

  describe "delete broadcaster" do
    setup [:create_broadcaster]

    test "deletes chosen broadcaster", %{conn: conn, broadcaster: broadcaster} do
      conn = delete(conn, Routes.broadcaster_path(conn, :delete, broadcaster))
      assert redirected_to(conn) == Routes.broadcaster_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.broadcaster_path(conn, :show, broadcaster))
      end
    end
  end

  defp create_broadcaster(_) do
    broadcaster = fixture(:broadcaster)
    %{broadcaster: broadcaster}
  end
end
