defmodule FutureMadeConcerts.ProfilesTest do
  use FutureMadeConcerts.DataCase

  alias FutureMadeConcerts.Profiles

  describe "non_gov_orgs" do
    alias FutureMadeConcerts.Profiles.NonGovOrg

    @valid_attrs %{description: "some description", headquarters: "some headquarters", image_url: "some image_url", name: "some name", number_of_followers: 42, number_of_open_projects: 42, number_of_volunteers_at_fm: 42, website_url: "some website_url"}
    @update_attrs %{description: "some updated description", headquarters: "some updated headquarters", image_url: "some updated image_url", name: "some updated name", number_of_followers: 43, number_of_open_projects: 43, number_of_volunteers_at_fm: 43, social_urls: [], website_url: "some updated website_url"}
    @invalid_attrs %{description: nil, headquarters: nil, image_url: nil, name: nil, number_of_followers: nil, number_of_open_projects: nil, number_of_volunteers_at_fm: nil,  website_url: nil}

    def non_gov_org_fixture(attrs \\ %{}) do
      {:ok, non_gov_org} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_non_gov_org()

      non_gov_org
    end

    test "list_non_gov_orgs/0 returns all non_gov_orgs" do
      non_gov_org = non_gov_org_fixture()
      assert Profiles.list_non_gov_orgs() == [non_gov_org]
    end

    test "get_non_gov_org!/1 returns the non_gov_org with given id" do
      non_gov_org = non_gov_org_fixture()
      assert Profiles.get_non_gov_org!(non_gov_org.id) == non_gov_org
    end

    test "create_non_gov_org/1 with valid data creates a non_gov_org" do
      assert {:ok, %NonGovOrg{} = non_gov_org} = Profiles.create_non_gov_org(@valid_attrs)
      assert non_gov_org.description == "some description"
      assert non_gov_org.headquarters == "some headquarters"
      assert non_gov_org.image_url == "some image_url"
      assert non_gov_org.name == "some name"
      assert non_gov_org.number_of_followers == 42
      assert non_gov_org.number_of_open_projects == 42
      assert non_gov_org.number_of_volunteers_at_fm == 42
      assert non_gov_org.social_urls == []
      assert non_gov_org.website_url == "some website_url"
    end

    test "create_non_gov_org/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_non_gov_org(@invalid_attrs)
    end

    test "update_non_gov_org/2 with valid data updates the non_gov_org" do
      non_gov_org = non_gov_org_fixture()
      assert {:ok, %NonGovOrg{} = non_gov_org} = Profiles.update_non_gov_org(non_gov_org, @update_attrs)
      assert non_gov_org.description == "some updated description"
      assert non_gov_org.headquarters == "some updated headquarters"
      assert non_gov_org.image_url == "some updated image_url"
      assert non_gov_org.name == "some updated name"
      assert non_gov_org.number_of_followers == 43
      assert non_gov_org.number_of_open_projects == 43
      assert non_gov_org.number_of_volunteers_at_fm == 43
      assert non_gov_org.social_urls == []
      assert non_gov_org.website_url == "some updated website_url"
    end

    test "update_non_gov_org/2 with invalid data returns error changeset" do
      non_gov_org = non_gov_org_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_non_gov_org(non_gov_org, @invalid_attrs)
      assert non_gov_org == Profiles.get_non_gov_org!(non_gov_org.id)
    end

    test "delete_non_gov_org/1 deletes the non_gov_org" do
      non_gov_org = non_gov_org_fixture()
      assert {:ok, %NonGovOrg{}} = Profiles.delete_non_gov_org(non_gov_org)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_non_gov_org!(non_gov_org.id) end
    end

    test "change_non_gov_org/1 returns a non_gov_org changeset" do
      non_gov_org = non_gov_org_fixture()
      assert %Ecto.Changeset{} = Profiles.change_non_gov_org(non_gov_org)
    end
  end

  describe "broadcasters" do
    alias FutureMadeConcerts.Profiles.Broadcaster

    @valid_attrs %{city: "some city", country: "some country", description: "some description", follower_count: 42, name: "some name"}
    @update_attrs %{city: "some updated city", country: "some updated country", description: "some updated description", follower_count: 43, name: "some updated name"}
    @invalid_attrs %{city: nil, country: nil, description: nil, follower_count: nil, name: nil}

    def broadcaster_fixture(attrs \\ %{}) do
      {:ok, broadcaster} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_broadcaster()

      broadcaster
    end

    test "list_broadcasters/0 returns all broadcasters" do
      broadcaster = broadcaster_fixture()
      assert Profiles.list_broadcasters() == [broadcaster]
    end

    test "get_broadcaster!/1 returns the broadcaster with given id" do
      broadcaster = broadcaster_fixture()
      assert Profiles.get_broadcaster!(broadcaster.id) == broadcaster
    end

    test "create_broadcaster/1 with valid data creates a broadcaster" do
      assert {:ok, %Broadcaster{} = broadcaster} = Profiles.create_broadcaster(@valid_attrs)
      assert broadcaster.city == "some city"
      assert broadcaster.country == "some country"
      assert broadcaster.description == "some description"
      assert broadcaster.follower_count == 42
      assert broadcaster.name == "some name"
    end

    test "create_broadcaster/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_broadcaster(@invalid_attrs)
    end

    test "update_broadcaster/2 with valid data updates the broadcaster" do
      broadcaster = broadcaster_fixture()
      assert {:ok, %Broadcaster{} = broadcaster} = Profiles.update_broadcaster(broadcaster, @update_attrs)
      assert broadcaster.city == "some updated city"
      assert broadcaster.country == "some updated country"
      assert broadcaster.description == "some updated description"
      assert broadcaster.follower_count == 43
      assert broadcaster.name == "some updated name"
    end

    test "update_broadcaster/2 with invalid data returns error changeset" do
      broadcaster = broadcaster_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_broadcaster(broadcaster, @invalid_attrs)
      assert broadcaster == Profiles.get_broadcaster!(broadcaster.id)
    end

    test "delete_broadcaster/1 deletes the broadcaster" do
      broadcaster = broadcaster_fixture()
      assert {:ok, %Broadcaster{}} = Profiles.delete_broadcaster(broadcaster)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_broadcaster!(broadcaster.id) end
    end

    test "change_broadcaster/1 returns a broadcaster changeset" do
      broadcaster = broadcaster_fixture()
      assert %Ecto.Changeset{} = Profiles.change_broadcaster(broadcaster)
    end
  end
end
