defmodule FutureMadeConcerts.Connectors.CauseNgo do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias FutureMadeConcerts.Repo

  alias FutureMadeConcerts.Meta.Cause
  alias FutureMadeConcerts.Profiles.NonGovOrg
  alias FutureMadeConcerts.Connectors.CauseNgo


  @primary_key false
  schema "causes_ngos" do
    belongs_to :cause, Cause
    belongs_to :non_gov_org, NonGovOrg
  end

  def changeset(%CauseNgo{} = cause_ngo, attrs) do
    cause_ngo
    |> cast(attrs, [:cause_id, :non_gov_org_id])
    |> Repo.insert!()
  end

end
