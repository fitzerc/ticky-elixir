defmodule Ticky.DateRangesTest do
  use Ticky.DataCase

  alias Ticky.DateRanges

  describe "date_range" do
    alias Ticky.DateRanges.DateRange

    import Ticky.DateRangesFixtures

    @invalid_attrs %{from_date: nil, to_date: nil}

    test "list_date_range/0 returns all date_range" do
      date_range = date_range_fixture()
      assert DateRanges.list_date_range() == [date_range]
    end

    test "get_date_range!/1 returns the date_range with given id" do
      date_range = date_range_fixture()
      assert DateRanges.get_date_range!(date_range.id) == date_range
    end

    test "create_date_range/1 with valid data creates a date_range" do
      valid_attrs = %{from_date: ~N[2024-09-18 02:11:00], to_date: ~N[2024-09-18 02:11:00]}

      assert {:ok, %DateRange{} = date_range} = DateRanges.create_date_range(valid_attrs)
      assert date_range.from_date == ~N[2024-09-18 02:11:00]
      assert date_range.to_date == ~N[2024-09-18 02:11:00]
    end

    test "create_date_range/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DateRanges.create_date_range(@invalid_attrs)
    end

    test "update_date_range/2 with valid data updates the date_range" do
      date_range = date_range_fixture()
      update_attrs = %{from_date: ~N[2024-09-19 02:11:00], to_date: ~N[2024-09-19 02:11:00]}

      assert {:ok, %DateRange{} = date_range} = DateRanges.update_date_range(date_range, update_attrs)
      assert date_range.from_date == ~N[2024-09-19 02:11:00]
      assert date_range.to_date == ~N[2024-09-19 02:11:00]
    end

    test "update_date_range/2 with invalid data returns error changeset" do
      date_range = date_range_fixture()
      assert {:error, %Ecto.Changeset{}} = DateRanges.update_date_range(date_range, @invalid_attrs)
      assert date_range == DateRanges.get_date_range!(date_range.id)
    end

    test "delete_date_range/1 deletes the date_range" do
      date_range = date_range_fixture()
      assert {:ok, %DateRange{}} = DateRanges.delete_date_range(date_range)
      assert_raise Ecto.NoResultsError, fn -> DateRanges.get_date_range!(date_range.id) end
    end

    test "change_date_range/1 returns a date_range changeset" do
      date_range = date_range_fixture()
      assert %Ecto.Changeset{} = DateRanges.change_date_range(date_range)
    end
  end
end
