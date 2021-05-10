defmodule FutureMadeConcerts.MetaTest do
  use FutureMadeConcerts.DataCase

  alias FutureMadeConcerts.Meta

  describe "genres" do
    alias FutureMadeConcerts.Meta.Genre

    @valid_attrs %{description: "some description", image_url: "some image_url", info_url: "some info_url", name: "some name"}
    @update_attrs %{description: "some updated description", image_url: "some updated image_url", info_url: "some updated info_url", name: "some updated name"}
    @invalid_attrs %{description: nil, image_url: nil, info_url: nil, name: nil}

    def genre_fixture(attrs \\ %{}) do
      {:ok, genre} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meta.create_genre()

      genre
    end

    test "list_genres/0 returns all genres" do
      genre = genre_fixture()
      assert Meta.list_genres() == [genre]
    end

    test "get_genre!/1 returns the genre with given id" do
      genre = genre_fixture()
      assert Meta.get_genre!(genre.id) == genre
    end

    test "create_genre/1 with valid data creates a genre" do
      assert {:ok, %Genre{} = genre} = Meta.create_genre(@valid_attrs)
      assert genre.description == "some description"
      assert genre.image_url == "some image_url"
      assert genre.info_url == "some info_url"
      assert genre.name == "some name"
    end

    test "create_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meta.create_genre(@invalid_attrs)
    end

    test "update_genre/2 with valid data updates the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{} = genre} = Meta.update_genre(genre, @update_attrs)
      assert genre.description == "some updated description"
      assert genre.image_url == "some updated image_url"
      assert genre.info_url == "some updated info_url"
      assert genre.name == "some updated name"
    end

    test "update_genre/2 with invalid data returns error changeset" do
      genre = genre_fixture()
      assert {:error, %Ecto.Changeset{}} = Meta.update_genre(genre, @invalid_attrs)
      assert genre == Meta.get_genre!(genre.id)
    end

    test "delete_genre/1 deletes the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{}} = Meta.delete_genre(genre)
      assert_raise Ecto.NoResultsError, fn -> Meta.get_genre!(genre.id) end
    end

    test "change_genre/1 returns a genre changeset" do
      genre = genre_fixture()
      assert %Ecto.Changeset{} = Meta.change_genre(genre)
    end
  end
end
