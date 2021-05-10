defmodule FutureMadeConcerts.Profiles do
  @moduledoc """
  The Profiles context.
  """

  import Ecto.Query, warn: false
  alias FutureMadeConcerts.Repo

  alias FutureMadeConcerts.Profiles.NonGovOrg
  alias FutureMadeConcerts.Profiles.Broadcaster
  alias FutureMadeConcerts.Meta.Cause


  @doc """
  Returns the list of non_gov_orgs.

  ## Examples

      iex> list_non_gov_orgs()
      [%NonGovOrg{}, ...]

  """
  def list_non_gov_orgs do
    Repo.all(NonGovOrg)
  end

  @doc """
  Gets a single non_gov_org.

  Raises `Ecto.NoResultsError` if the Non gov org does not exist.

  ## Examples

      iex> get_non_gov_org!(123)
      %NonGovOrg{}

      iex> get_non_gov_org!(456)
      ** (Ecto.NoResultsError)

  """
  def get_non_gov_org!(id), do: Repo.get!(NonGovOrg, id) |> Repo.preload(:causes)

  @doc """
  Creates a non_gov_org.

  ## Examples

      iex> create_non_gov_org(%{field: value})
      {:ok, %NonGovOrg{}}

      iex> create_non_gov_org(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_non_gov_org(attrs \\ %{}) do
    %NonGovOrg{}
    |> NonGovOrg.changeset(attrs)
    |> maybe_put_causes(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a non_gov_org.

  ## Examples

      iex> update_non_gov_org(non_gov_org, %{field: new_value})
      {:ok, %NonGovOrg{}}

      iex> update_non_gov_org(non_gov_org, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_non_gov_org(%NonGovOrg{} = non_gov_org, attrs) do
    non_gov_org
    |> NonGovOrg.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a non_gov_org.

  ## Examples

      iex> delete_non_gov_org(non_gov_org)
      {:ok, %NonGovOrg{}}

      iex> delete_non_gov_org(non_gov_org)
      {:error, %Ecto.Changeset{}}

  """
  def delete_non_gov_org(%NonGovOrg{} = non_gov_org) do
    Repo.delete(non_gov_org)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking non_gov_org changes.

  ## Examples

      iex> change_non_gov_org(non_gov_org)
      %Ecto.Changeset{data: %NonGovOrg{}}

  """
  def change_non_gov_org(%NonGovOrg{} = non_gov_org, attrs \\ %{}) do
    NonGovOrg.changeset(non_gov_org, attrs)
  end

  def add_cause_to_ngo(ngo = %NonGovOrg{}, cause = %Cause{}) do
    ngo = Repo.preload(ngo, :causes)
    causes = ngo.causes ++ [cause]
                    |> Enum.map(&Ecto.Changeset.change/1)

    cause
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:causes, causes)
    |> Repo.update
  end

  defp maybe_put_causes(changeset, []), do: changeset

  defp maybe_put_causes(changeset, attrs) do
    causes = get_causes(attrs["causes"])

    Ecto.Changeset.put_assoc(changeset, :causes, causes)
  end

  def get_causes(nil), do: []

  def get_causes(ids) do
    Repo.all(from c in Cause, where: c.id in ^ids)
  end

  def load_causes(non_gov_org), do: Repo.preload(non_gov_org, :causes)

  def list_broadcasters() do
    Repo.all(Broadcaster)
  end

  def get_broadcaster!(id), do: Repo.get!(Broadcaster, id)

  @doc """
  Creates a broadcaster.

  ## Examples

      iex> create_broadcaster(%{field: value})
      {:ok, %Broadcaster{}}

      iex> create_broadcaster(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_broadcaster(attrs \\ %{}) do
    %Broadcaster{}
    |> Broadcaster.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a broadcaster.

  ## Examples

      iex> update_broadcaster(broadcaster, %{field: new_value})
      {:ok, %Broadcaster{}}

      iex> update_broadcaster(broadcaster, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_broadcaster(%Broadcaster{} = broadcaster, attrs) do
    broadcaster
    |> Broadcaster.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a broadcaster.

  ## Examples

      iex> delete_broadcaster(broadcaster)
      {:ok, %Broadcaster{}}

      iex> delete_broadcaster(broadcaster)
      {:error, %Ecto.Changeset{}}

  """
  def delete_broadcaster(%Broadcaster{} = broadcaster) do
    Repo.delete(broadcaster)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking broadcaster changes.

  ## Examples

      iex> change_broadcaster(broadcaster)
      %Ecto.Changeset{data: %Broadcaster{}}

  """
  def change_broadcaster(%Broadcaster{} = broadcaster, attrs \\ %{}) do
    Broadcaster.changeset(broadcaster, attrs)
  end
end
