defmodule FutureMadeConcertsWeb.AlbumView do
  @moduledoc false
  use FutureMadeConcertsWeb, :view

  alias FutureMadeConcerts.{Link, Spotify.Schema.Album, Spotify.Schema.Copyright}
  alias FutureMadeConcertsWeb.TrackView

  @default_artwork "https://via.placeholder.com/300"

  defp authors(%Album{artists: artists}, socket) do
    artists
    |> Enum.map(fn artist ->
      live_patch(artist.name, to: Routes.explorer_path(socket, :artist_details, artist.id))
    end)
    |> Enum.intersperse(", ")
  end

  @spec artwork(Album.t()) :: String.t()
  defp artwork(%Album{thumbnails: thumbnails}),
    do: Map.get(thumbnails, :medium, @default_artwork)

  @spec total_duration(Album.t()) :: String.t()
  defp total_duration(album) do
    formatted_duration =
      album
      |> Album.total_duration_ms()
      |> FutureMadeConcerts.Duration.human()

    tracks_count = Album.tracks_count(album)

    ngettext(
      "1 track, %{formatted_duration}",
      "%{count} tracks, %{formatted_duration}",
      tracks_count,
      %{formatted_duration: formatted_duration}
    )
  end

  @spec genre(Album.t()) :: nil | String.t()
  defp genre(%Album{genres: []}), do: nil

  defp genre(%Album{genres: genres}) do
    content_tag :h3, class: "genre" do
      Enum.join(genres, ", ")
    end
  end

  @spec copyright_icon(Copyright.t()) :: Phoenix.HTML.safe()
  defp copyright_icon(%Copyright{type: "C"}), do: raw("&copy;")
  defp copyright_icon(%Copyright{type: "P"}), do: raw("&copysr;")
end
