defmodule Ticky.DateRanges do
  @moduledoc """
  The DateRanges context.
  """

  import Ecto.Query, warn: false
  alias Ticky.Repo

  alias Ticky.DateRanges.DateRange

  @doc """
  Returns the list of date_range.

  ## Examples

      iex> list_date_range()
      [%DateRange{}, ...]

  """
  def list_date_range do
    Repo.all(DateRange)
  end

  @doc """
  Gets a single date_range.

  Raises `Ecto.NoResultsError` if the Date range does not exist.

  ## Examples

      iex> get_date_range!(123)
      %DateRange{}

      iex> get_date_range!(456)
      ** (Ecto.NoResultsError)

  """
  def get_date_range!(id), do: Repo.get!(DateRange, id)

  @doc """
  Creates a date_range.

  ## Examples

      iex> create_date_range(%{field: value})
      {:ok, %DateRange{}}

      iex> create_date_range(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_date_range(attrs \\ %{}) do
    %DateRange{}
    |> DateRange.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a date_range.

  ## Examples

      iex> update_date_range(date_range, %{field: new_value})
      {:ok, %DateRange{}}

      iex> update_date_range(date_range, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_date_range(%DateRange{} = date_range, attrs) do
    date_range
    |> DateRange.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a date_range.

  ## Examples

      iex> delete_date_range(date_range)
      {:ok, %DateRange{}}

      iex> delete_date_range(date_range)
      {:error, %Ecto.Changeset{}}

  """
  def delete_date_range(%DateRange{} = date_range) do
    Repo.delete(date_range)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking date_range changes.

  ## Examples

      iex> change_date_range(date_range)
      %Ecto.Changeset{data: %DateRange{}}

  """
  def change_date_range(%DateRange{} = date_range, attrs \\ %{}) do
    DateRange.changeset(date_range, attrs)
  end
end
