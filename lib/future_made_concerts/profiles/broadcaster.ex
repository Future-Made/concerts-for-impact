defmodule FutureMadeConcerts.Profiles.Broadcaster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "broadcasters" do
    field :city, :string
    field :country, :string
    field :description, :string
    field :follower_count, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(broadcaster, attrs) do
    broadcaster
    |> cast(attrs, [:name, :description, :follower_count, :city, :country])
    |> validate_required([:name, :description, :follower_count, :city, :country])
  end
end
