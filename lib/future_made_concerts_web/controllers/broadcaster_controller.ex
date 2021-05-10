defmodule FutureMadeConcertsWeb.BroadcasterController do
  use FutureMadeConcertsWeb, :controller

  alias FutureMadeConcerts.Profiles
  alias FutureMadeConcerts.Profiles.Broadcaster

  def index(conn, _params) do
    broadcasters = Profiles.list_broadcasters()
    render(conn, "index.html", broadcasters: broadcasters)
  end

  def new(conn, _params) do
    changeset = Profiles.change_broadcaster(%Broadcaster{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"broadcaster" => broadcaster_params}) do
    case Profiles.create_broadcaster(broadcaster_params) do
      {:ok, broadcaster} ->
        conn
        |> put_flash(:info, "Broadcaster created successfully.")
        |> redirect(to: Routes.broadcaster_path(conn, :show, broadcaster))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    broadcaster = Profiles.get_broadcaster!(id)
    render(conn, "show.html", broadcaster: broadcaster)
  end

  def edit(conn, %{"id" => id}) do
    broadcaster = Profiles.get_broadcaster!(id)
    changeset = Profiles.change_broadcaster(broadcaster)
    render(conn, "edit.html", broadcaster: broadcaster, changeset: changeset)
  end

  def update(conn, %{"id" => id, "broadcaster" => broadcaster_params}) do
    broadcaster = Profiles.get_broadcaster!(id)

    case Profiles.update_broadcaster(broadcaster, broadcaster_params) do
      {:ok, broadcaster} ->
        conn
        |> put_flash(:info, "Broadcaster updated successfully.")
        |> redirect(to: Routes.broadcaster_path(conn, :show, broadcaster))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", broadcaster: broadcaster, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    broadcaster = Profiles.get_broadcaster!(id)
    {:ok, _broadcaster} = Profiles.delete_broadcaster(broadcaster)

    conn
    |> put_flash(:info, "Broadcaster deleted successfully.")
    |> redirect(to: Routes.broadcaster_path(conn, :index))
  end
end
