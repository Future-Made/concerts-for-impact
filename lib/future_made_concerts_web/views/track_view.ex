defmodule FutureMadeConcertsWeb.TrackView do
  @moduledoc false
  use FutureMadeConcertsWeb, :view

  alias FutureMadeConcerts.Spotify.Schema.{Player, Track}
  alias FutureMadeConcerts.Link

  @spec playing?(Track.t(), Player.t()) :: boolean()
  defp playing?(%Track{id: track_id}, %Player{status: :playing, item: %{id: track_id}}),
    do: true

  defp playing?(_track, _now_playing), do: false
end
