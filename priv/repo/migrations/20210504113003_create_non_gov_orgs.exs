defmodule FutureMadeConcerts.Repo.Migrations.CreateNonGovOrgs do
  use Ecto.Migration

  def change do
    create table(:non_gov_orgs) do
      add :name, :string
      add :description, :text
      add :headquarters, :string
      add :number_of_volunteers_at_fm, :integer
      add :number_of_followers, :integer
      add :number_of_open_projects, :integer
      add :image_url, :string
      add :website_url, :string

      timestamps()
    end

  end
end
