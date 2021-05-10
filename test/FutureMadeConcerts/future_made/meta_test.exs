defmodule FutureMadeConcerts.MetaTest do
  use FutureMadeConcerts.DataCase

  alias FutureMadeConcerts.Meta

  describe "causes" do
    alias FutureMadeConcerts.Meta.Cause

    @valid_attrs %{description: "some description", image_url: "some image_url", info_url: "some info_url", name: "some name"}
    @update_attrs %{description: "some updated description", image_url: "some updated image_url", info_url: "some updated info_url", name: "some updated name"}
    @invalid_attrs %{description: nil, image_url: nil, info_url: nil, name: nil}

    def cause_fixture(attrs \\ %{}) do
      {:ok, cause} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meta.create_cause()

      cause
    end

    test "list_causes/0 returns all causes" do
      cause = cause_fixture()
      assert Meta.list_causes() == [cause]
    end

    test "get_cause!/1 returns the cause with given id" do
      cause = cause_fixture()
      assert Meta.get_cause!(cause.id) == cause
    end

    test "create_cause/1 with valid data creates a cause" do
      assert {:ok, %Cause{} = cause} = Meta.create_cause(@valid_attrs)
      assert cause.description == "some description"
      assert cause.image_url == "some image_url"
      assert cause.info_url == "some info_url"
      assert cause.name == "some name"
    end

    test "create_cause/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meta.create_cause(@invalid_attrs)
    end

    test "update_cause/2 with valid data updates the cause" do
      cause = cause_fixture()
      assert {:ok, %Cause{} = cause} = Meta.update_cause(cause, @update_attrs)
      assert cause.description == "some updated description"
      assert cause.image_url == "some updated image_url"
      assert cause.info_url == "some updated info_url"
      assert cause.name == "some updated name"
    end

    test "update_cause/2 with invalid data returns error changeset" do
      cause = cause_fixture()
      assert {:error, %Ecto.Changeset{}} = Meta.update_cause(cause, @invalid_attrs)
      assert cause == Meta.get_cause!(cause.id)
    end

    test "delete_cause/1 deletes the cause" do
      cause = cause_fixture()
      assert {:ok, %Cause{}} = Meta.delete_cause(cause)
      assert_raise Ecto.NoResultsError, fn -> Meta.get_cause!(cause.id) end
    end

    test "change_cause/1 returns a cause changeset" do
      cause = cause_fixture()
      assert %Ecto.Changeset{} = Meta.change_cause(cause)
    end
  end
end
