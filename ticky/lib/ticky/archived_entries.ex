defmodule Ticky.ArchivedEntries do
  @moduledoc """
  The ArchivedEntries context.
  """

  import Ecto.Query, warn: false
  alias Ticky.Repo

  alias Ticky.ArchivedEntries.ArchivedEntry

  @doc """
  Returns the list of archived_entry.

  ## Examples

      iex> list_archived_entry()
      [%ArchivedEntry{}, ...]

  """
  def list_archived_entry do
    Repo.all(ArchivedEntry)
  end

  @doc """
  Gets a single archived_entry.

  Raises `Ecto.NoResultsError` if the Archived entry does not exist.

  ## Examples

      iex> get_archived_entry!(123)
      %ArchivedEntry{}

      iex> get_archived_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_archived_entry!(id), do: Repo.get!(ArchivedEntry, id)

  @doc """
  Creates a archived_entry.

  ## Examples

      iex> create_archived_entry(%{field: value})
      {:ok, %ArchivedEntry{}}

      iex> create_archived_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_archived_entry(attrs \\ %{}) do
    %ArchivedEntry{}
    |> ArchivedEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a archived_entry.

  ## Examples

      iex> update_archived_entry(archived_entry, %{field: new_value})
      {:ok, %ArchivedEntry{}}

      iex> update_archived_entry(archived_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_archived_entry(%ArchivedEntry{} = archived_entry, attrs) do
    archived_entry
    |> ArchivedEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a archived_entry.

  ## Examples

      iex> delete_archived_entry(archived_entry)
      {:ok, %ArchivedEntry{}}

      iex> delete_archived_entry(archived_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_archived_entry(%ArchivedEntry{} = archived_entry) do
    Repo.delete(archived_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking archived_entry changes.

  ## Examples

      iex> change_archived_entry(archived_entry)
      %Ecto.Changeset{data: %ArchivedEntry{}}

  """
  def change_archived_entry(%ArchivedEntry{} = archived_entry, attrs \\ %{}) do
    ArchivedEntry.changeset(archived_entry, attrs)
  end
end
