defmodule FutureMadeConcerts.Repo.Migrations.CausesNgos do
  use Ecto.Migration

  def change do
    create table("causes_ngos", primary_key: false) do
      add :cause_id, references(:causes)
      add :non_gov_org_id, references(:non_gov_orgs)
    end

    create index(:causes_ngos, [:cause_id])
    create index(:causes_ngos, [:non_gov_org_id])

    create unique_index(:causes_ngos, [:cause_id, :non_gov_org_id])
  end
end
