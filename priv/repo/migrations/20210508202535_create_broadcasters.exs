defmodule FutureMadeConcerts.Repo.Migrations.CreateBroadcasters do
  use Ecto.Migration

  def change do
    create table(:broadcasters) do
      add :name, :string
      add :description, :text
      add :follower_count, :integer
      add :city, :string
      add :country, :string

      timestamps()
    end

  end
end
