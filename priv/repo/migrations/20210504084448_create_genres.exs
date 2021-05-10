defmodule FutureMadeConcerts.Repo.Migrations.CreateGenres do
  use Ecto.Migration

  def change do
    create table(:genres) do
      add :name, :string
      add :description, :text
      add :image_url, :string
      add :info_url, :string

      timestamps()
    end

  end
end
