defmodule FutureMadeConcerts.Repo.Migrations.AddIndexToNgosCauses do
  use Ecto.Migration

  def change do
    alter table(:causes_ngos) do
      create unique_index(:causes_ngos, [:cause_id, :non_gov_org_id])
    end
  end
end
