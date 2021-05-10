defmodule FutureMadeConcerts.Meta.Genre do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genres" do
    field :description, :string
    field :image_url, :string
    field :info_url, :string
    field :name, :string

    timestamps()
  end

@doc false
  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name, :description, :image_url, :info_url])
    |> validate_required([:name, :description, :image_url, :info_url])
  end
end
