defmodule FutureMadeConcerts.Profiles.NonGovOrg do
  use Ecto.Schema
  import Ecto.Changeset

  alias FutureMadeConcerts.Meta.Cause

  schema "non_gov_orgs" do
    field :description, :string
    field :name, :string
    field :headquarters, :string
    field :image_url, :string
    field :website_url, :string
    field :number_of_followers, :integer, default: 0
    field :number_of_open_projects, :integer, default: 0

    many_to_many :causes, Cause,
        join_through: "causes_ngos"
    timestamps()
  end

  @doc false
  def changeset(non_gov_org, attrs) do
    non_gov_org
    |> cast(attrs, [:name, :description, :headquarters, :image_url, :website_url])
    |> cast_assoc(:causes, required: false)
    |> validate_required([:name, :description, :headquarters])
  end
end
