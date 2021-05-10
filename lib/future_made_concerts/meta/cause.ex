defmodule FutureMadeConcerts.Meta.Cause do
  use Ecto.Schema
  import Ecto.Changeset

  alias FutureMadeConcerts.Profiles.NonGovOrg

  schema "causes" do
    field :description, :string
    field :image_url, :string
    field :info_url, :string
    field :name, :string

    many_to_many :non_gov_orgs, NonGovOrg,
      join_through: "causes_ngos"

    timestamps()
  end

  @doc false
  def changeset(cause, attrs) do
    cause
    |> cast(attrs, [:name, :description, :image_url, :info_url])
    |> cast_assoc(:non_gov_orgs, required: false)
    |> validate_required([:name, :description, :image_url, :info_url])
  end
end
