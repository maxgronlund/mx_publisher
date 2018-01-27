defmodule MxPublisher.MxNodesTest do
  use MxPublisher.DataCase

  alias MxPublisher.MxNodes

  describe "trackers" do
    alias MxPublisher.MxNodes.Tracker

    @valid_attrs %{adress: "some adress", api_key: "some api_key", certificate: "some certificate"}
    @update_attrs %{adress: "some updated adress", api_key: "some updated api_key", certificate: "some updated certificate"}
    @invalid_attrs %{adress: nil, api_key: nil, certificate: nil}

    def tracker_fixture(attrs \\ %{}) do
      {:ok, tracker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MxNodes.create_tracker()

      tracker
    end

    test "list_trackers/0 returns all trackers" do
      tracker = tracker_fixture()
      assert MxNodes.list_trackers() == [tracker]
    end

    test "get_tracker!/1 returns the tracker with given id" do
      tracker = tracker_fixture()
      assert MxNodes.get_tracker!(tracker.id) == tracker
    end

    test "create_tracker/1 with valid data creates a tracker" do
      assert {:ok, %Tracker{} = tracker} = MxNodes.create_tracker(@valid_attrs)
      assert tracker.adress == "some adress"
      assert tracker.api_key == "some api_key"
      assert tracker.certificate == "some certificate"
    end

    test "create_tracker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MxNodes.create_tracker(@invalid_attrs)
    end

    test "update_tracker/2 with valid data updates the tracker" do
      tracker = tracker_fixture()
      assert {:ok, tracker} = MxNodes.update_tracker(tracker, @update_attrs)
      assert %Tracker{} = tracker
      assert tracker.adress == "some updated adress"
      assert tracker.api_key == "some updated api_key"
      assert tracker.certificate == "some updated certificate"
    end

    test "update_tracker/2 with invalid data returns error changeset" do
      tracker = tracker_fixture()
      assert {:error, %Ecto.Changeset{}} = MxNodes.update_tracker(tracker, @invalid_attrs)
      assert tracker == MxNodes.get_tracker!(tracker.id)
    end

    test "delete_tracker/1 deletes the tracker" do
      tracker = tracker_fixture()
      assert {:ok, %Tracker{}} = MxNodes.delete_tracker(tracker)
      assert_raise Ecto.NoResultsError, fn -> MxNodes.get_tracker!(tracker.id) end
    end

    test "change_tracker/1 returns a tracker changeset" do
      tracker = tracker_fixture()
      assert %Ecto.Changeset{} = MxNodes.change_tracker(tracker)
    end
  end
end
