defmodule Ticky.TimeEntries do
  @moduledoc """
  The TimeEntries context.
  """

  import Ecto.Query, warn: false
  alias Ticky.Repo

  alias Ticky.TimeEntries.TimeEntry
  alias Ticky.ArchivedEntries.ArchivedEntry

  @doc """
  Returns the list of time_entries.

  ## Examples

      iex> list_time_entries()
      [%TimeEntry{}, ...]

  """
  def list_time_entries do
    Repo.all(TimeEntry)
  end

  def list_users_time_entries(user_id) do
    from(te in TimeEntry, where: te.user_id == ^user_id, select: te)
    |> Repo.all()
  end

  def list_users_unarchived_time_entries(user_id) do
    query =
      from te in TimeEntry,
        left_join: ae in ArchivedEntry,
        on: te.id == ae.time_entry_id,
        where: te.user_id == ^user_id and is_nil(ae.time_entry_id),
        select: te

    Repo.all(query)
  end

  def list_time_entries_between_for_user(from_date, to_date, user_id) do
    from(te in TimeEntry,
      where: te.user_id == ^user_id and te.started_at >= ^from_date and te.started_at <= ^to_date
    )
    |> Repo.all()
  end

  def list_unarchived_time_entries_between_for_user(from_date, to_date, user_id) do
    query =
      from te in TimeEntry,
        left_join: ae in ArchivedEntry,
        on: te.id == ae.time_entry_id,
        where:
          te.user_id == ^user_id and te.started_at >= ^from_date and te.started_at <= ^to_date and
            is_nil(ae.time_entry_id),
        select: te

    Repo.all(query)
  end

  def get_time_entries_for_day(user_id, date) do
    from(te in TimeEntry, where: te.user_id == ^user_id and te.started_at >= ^date)
    |> Repo.all()
  end

  def list_unarchived_time_entries_after_day(user_id, date) do
    query =
      from te in TimeEntry,
        left_join: ae in ArchivedEntry,
        on: te.id == ae.time_entry_id,
        where: te.user_id == ^user_id and te.started_at >= ^date and is_nil(ae.time_entry_id),
        select: te

    Repo.all(query)
  end

  def list_time_entries_by_archive(archive_id) do
    query =
      from te in TimeEntry,
        join: ae in ArchivedEntry,
        on: te.id == ae.time_entry_id,
        where: ae.time_entry_archive_id == ^archive_id,
        select: te

    Repo.all(query)
  end

  @doc """
  Gets a single time_entry.

  Raises `Ecto.NoResultsError` if the Time entry does not exist.

  ## Examples

      iex> get_time_entry!(123)
      %TimeEntry{}

      iex> get_time_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time_entry!(id), do: Repo.get!(TimeEntry, id)

  @doc """
  Creates a time_entry.

  ## Examples

      iex> create_time_entry(%{field: value})
      {:ok, %TimeEntry{}}

      iex> create_time_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time_entry(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:time_entries)
    |> TimeEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time_entry.

  ## Examples

      iex> update_time_entry(time_entry, %{field: new_value})
      {:ok, %TimeEntry{}}

      iex> update_time_entry(time_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_entry(%TimeEntry{} = time_entry, attrs) do
    time_entry
    |> TimeEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a time_entry.

  ## Examples

      iex> delete_time_entry(time_entry)
      {:ok, %TimeEntry{}}

      iex> delete_time_entry(time_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_entry(%TimeEntry{} = time_entry) do
    Repo.delete(time_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_entry changes.

  ## Examples

      iex> change_time_entry(time_entry)
      %Ecto.Changeset{data: %TimeEntry{}}

  """
  def change_time_entry(%TimeEntry{} = time_entry, attrs \\ %{}) do
    TimeEntry.changeset(time_entry, attrs)
  end
end
