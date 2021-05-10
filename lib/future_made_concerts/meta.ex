defmodule FutureMadeConcerts.Meta do
  @moduledoc """
  The FutureMade.Meta context.
  """

  import Ecto.Query, warn: false
  alias FutureMadeConcerts.Repo

  alias FutureMadeConcerts.Meta.Cause
  alias FutureMadeConcerts.Profiles.NonGovOrg

  @doc """
  Returns the list of causes.

  ## Examples

      iex> list_causes()
      [%Cause{}, ...]

  """
  def list_causes do
    Repo.all(Cause)
  end

  @doc """
  Gets a single cause.

  Raises `Ecto.NoResultsError` if the Cause does not exist.

  ## Examples

      iex> get_cause!(123)
      %Cause{}

      iex> get_cause!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cause!(id), do: Repo.get!(Cause, id)

  @doc """
  Creates a cause.

  ## Examples

      iex> create_cause(%{field: value})
      {:ok, %Cause{}}

      iex> create_cause(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cause(attrs \\ %{}) do
    %Cause{}
    |> Cause.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cause.

  ## Examples

      iex> update_cause(cause, %{field: new_value})
      {:ok, %Cause{}}

      iex> update_cause(cause, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cause(%Cause{} = cause, attrs) do
    cause
    |> Cause.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cause.

  ## Examples

      iex> delete_cause(cause)
      {:ok, %Cause{}}

      iex> delete_cause(cause)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cause(%Cause{} = cause) do
    Repo.delete(cause)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cause changes.

  ## Examples

      iex> change_cause(cause)
      %Ecto.Changeset{data: %Cause{}}

  """
  def change_cause(%Cause{} = cause, attrs \\ %{}) do
    Cause.changeset(cause, attrs)
  end

  def add_ngo_to_cause(cause = %Cause{}, ngo = %NonGovOrg{}) do
    cause = Repo.preload(cause, :non_gov_orgs)
    non_gov_orgs = cause.non_gov_orgs ++ [ngo]
                    |> Enum.map(&Ecto.Changeset.change/1)

    cause
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:non_gov_orgs, non_gov_orgs)
    |> Repo.update
  end


  alias FutureMadeConcerts.Meta.Genre

  @doc """
  Returns the list of genres.

  ## Examples

      iex> list_genres()
      [%Genre{}, ...]

  """
  def list_genres do
    Repo.all(Genre)
  end

  @doc """
  Gets a single genre.

  Raises `Ecto.NoResultsError` if the Genre does not exist.

  ## Examples

      iex> get_genre!(123)
      %Genre{}

      iex> get_genre!(456)
      ** (Ecto.NoResultsError)

  """
  def get_genre!(id), do: Repo.get!(Genre, id)

  @doc """
  Creates a genre.

  ## Examples

      iex> create_genre(%{field: value})
      {:ok, %Genre{}}

      iex> create_genre(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a genre.

  ## Examples

      iex> update_genre(genre, %{field: new_value})
      {:ok, %Genre{}}

      iex> update_genre(genre, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a genre.

  ## Examples

      iex> delete_genre(genre)
      {:ok, %Genre{}}

      iex> delete_genre(genre)
      {:error, %Ecto.Changeset{}}

  """
  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking genre changes.

  ## Examples

      iex> change_genre(genre)
      %Ecto.Changeset{data: %Genre{}}

  """
  def change_genre(%Genre{} = genre, attrs \\ %{}) do
    Genre.changeset(genre, attrs)
  end
end
