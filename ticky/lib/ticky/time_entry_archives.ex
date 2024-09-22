defmodule Ticky.TimeEntryArchives do
  @moduledoc """
  The TimeEntryArchives context.
  """

  import Ecto.Query, warn: false
  alias Ticky.Repo

  alias Ticky.TimeEntryArchives.TimeEntryArchive

  @doc """
  Returns the list of time_entry_archives.

  ## Examples

      iex> list_time_entry_archives()
      [%TimeEntryArchive{}, ...]

  """
  def list_time_entry_archives do
    Repo.all(TimeEntryArchive)
  end

  def list_users_time_entry_archives(user_id) do
    from(tea in TimeEntryArchive, where: tea.user_id == ^user_id, select: tea)
    |> Repo.all()
  end

  @doc """
  Gets a single time_entry_archive.

  Raises `Ecto.NoResultsError` if the Time entry archive does not exist.

  ## Examples

      iex> get_time_entry_archive!(123)
      %TimeEntryArchive{}

      iex> get_time_entry_archive!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time_entry_archive!(id), do: Repo.get!(TimeEntryArchive, id)

  @doc """
  Creates a time_entry_archive.

  ## Examples

      iex> create_time_entry_archive(%{field: value})
      {:ok, %TimeEntryArchive{}}

      iex> create_time_entry_archive(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time_entry_archive(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:time_entry_archives)
    |> TimeEntryArchive.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time_entry_archive.

  ## Examples

      iex> update_time_entry_archive(time_entry_archive, %{field: new_value})
      {:ok, %TimeEntryArchive{}}

      iex> update_time_entry_archive(time_entry_archive, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_entry_archive(%TimeEntryArchive{} = time_entry_archive, attrs) do
    time_entry_archive
    |> TimeEntryArchive.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a time_entry_archive.

  ## Examples

      iex> delete_time_entry_archive(time_entry_archive)
      {:ok, %TimeEntryArchive{}}

      iex> delete_time_entry_archive(time_entry_archive)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_entry_archive(%TimeEntryArchive{} = time_entry_archive) do
    Repo.delete(time_entry_archive)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_entry_archive changes.

  ## Examples

      iex> change_time_entry_archive(time_entry_archive)
      %Ecto.Changeset{data: %TimeEntryArchive{}}

  """
  def change_time_entry_archive(%TimeEntryArchive{} = time_entry_archive, attrs \\ %{}) do
    TimeEntryArchive.changeset(time_entry_archive, attrs)
  end
end
