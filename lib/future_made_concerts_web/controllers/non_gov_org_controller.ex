defmodule FutureMadeConcertsWeb.NonGovOrgController do
  use FutureMadeConcertsWeb, :controller

  alias FutureMadeConcerts.Profiles
  alias FutureMadeConcerts.Profiles.NonGovOrg
  alias FutureMadeConcerts.Meta

  def index(conn, _params) do
    non_gov_orgs = Profiles.list_non_gov_orgs()
    render(conn, "index.html", non_gov_orgs: non_gov_orgs)
  end

  def new(conn, _params) do
    all_causes = Meta.list_causes()
    changeset = Profiles.change_non_gov_org(%NonGovOrg{})

    # initially render all causes and let user select multiple of those.
    render(conn, "new.html", changeset: changeset, causes: all_causes)
  end

  def create(conn, %{"non_gov_org" => non_gov_org_params}) do
    non_gov_org_params |> IO.inspect()

    case Profiles.create_non_gov_org(non_gov_org_params) do
      {:ok, non_gov_org} ->
        conn
        |> put_flash(:info, "Non gov org created successfully.")
        |> redirect(to: Routes.non_gov_org_path(conn, :show, non_gov_org))

      {:error, %Ecto.Changeset{} = changeset} ->
        data = Profiles.load_causes(changeset.data)
        all_causes = Meta.list_causes()

        conn
        |> put_flash(:error, "Error!")
        |> render("new.html", changeset: %{changeset | data: data}, causes: all_causes)
    end
  end

  def show(conn, %{"id" => id}) do
    non_gov_org = Profiles.get_non_gov_org!(id)
    render(conn, "show.html", non_gov_org: non_gov_org)
  end

  def edit(conn, %{"id" => id}) do
    non_gov_org = Profiles.get_non_gov_org!(id)
    changeset = Profiles.change_non_gov_org(non_gov_org)
    render(conn, "edit.html", non_gov_org: non_gov_org, changeset: changeset)
  end

  def update(conn, %{"id" => id, "non_gov_org" => non_gov_org_params}) do
    non_gov_org = Profiles.get_non_gov_org!(id)

    case Profiles.update_non_gov_org(non_gov_org, non_gov_org_params) do
      {:ok, non_gov_org} ->
        conn
        |> put_flash(:info, "Non gov org updated successfully.")
        |> redirect(to: Routes.non_gov_org_path(conn, :show, non_gov_org))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", non_gov_org: non_gov_org, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    non_gov_org = Profiles.get_non_gov_org!(id)
    {:ok, _non_gov_org} = Profiles.delete_non_gov_org(non_gov_org)

    conn
    |> put_flash(:info, "Non gov org deleted successfully.")
    |> redirect(to: Routes.non_gov_org_path(conn, :index))
  end
end
