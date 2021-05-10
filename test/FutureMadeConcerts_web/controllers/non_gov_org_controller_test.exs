defmodule FutureMadeConcertsWeb.NonGovOrgControllerTest do
  use FutureMadeConcertsWeb.ConnCase

  alias FutureMadeConcerts.Profiles

  @create_attrs %{description: "some description", headquarters: "some headquarters", image_url: "some image_url", name: "some name", number_of_followers: 42, number_of_open_projects: 42, number_of_volunteers_at_fm: 42, social_urls: [], website_url: "some website_url"}
  @update_attrs %{description: "some updated description", headquarters: "some updated headquarters", image_url: "some updated image_url", name: "some updated name", number_of_followers: 43, number_of_open_projects: 43, number_of_volunteers_at_fm: 43, social_urls: [], website_url: "some updated website_url"}
  @invalid_attrs %{description: nil, headquarters: nil, image_url: nil, name: nil, number_of_followers: nil, number_of_open_projects: nil, number_of_volunteers_at_fm: nil, social_urls: nil, website_url: nil}

  def fixture(:non_gov_org) do
    {:ok, non_gov_org} = Profiles.create_non_gov_org(@create_attrs)
    non_gov_org
  end

  describe "index" do
    test "lists all non_gov_orgs", %{conn: conn} do
      conn = get(conn, Routes.non_gov_org_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Non gov orgs"
    end
  end

  describe "new non_gov_org" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.non_gov_org_path(conn, :new))
      assert html_response(conn, 200) =~ "New Non gov org"
    end
  end

  describe "create non_gov_org" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.non_gov_org_path(conn, :create), non_gov_org: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.non_gov_org_path(conn, :show, id)

      conn = get(conn, Routes.non_gov_org_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Non gov org"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.non_gov_org_path(conn, :create), non_gov_org: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Non gov org"
    end
  end

  describe "edit non_gov_org" do
    setup [:create_non_gov_org]

    test "renders form for editing chosen non_gov_org", %{conn: conn, non_gov_org: non_gov_org} do
      conn = get(conn, Routes.non_gov_org_path(conn, :edit, non_gov_org))
      assert html_response(conn, 200) =~ "Edit Non gov org"
    end
  end

  describe "update non_gov_org" do
    setup [:create_non_gov_org]

    test "redirects when data is valid", %{conn: conn, non_gov_org: non_gov_org} do
      conn = put(conn, Routes.non_gov_org_path(conn, :update, non_gov_org), non_gov_org: @update_attrs)
      assert redirected_to(conn) == Routes.non_gov_org_path(conn, :show, non_gov_org)

      conn = get(conn, Routes.non_gov_org_path(conn, :show, non_gov_org))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, non_gov_org: non_gov_org} do
      conn = put(conn, Routes.non_gov_org_path(conn, :update, non_gov_org), non_gov_org: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Non gov org"
    end
  end

  describe "delete non_gov_org" do
    setup [:create_non_gov_org]

    test "deletes chosen non_gov_org", %{conn: conn, non_gov_org: non_gov_org} do
      conn = delete(conn, Routes.non_gov_org_path(conn, :delete, non_gov_org))
      assert redirected_to(conn) == Routes.non_gov_org_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.non_gov_org_path(conn, :show, non_gov_org))
      end
    end
  end

  defp create_non_gov_org(_) do
    non_gov_org = fixture(:non_gov_org)
    %{non_gov_org: non_gov_org}
  end
end
