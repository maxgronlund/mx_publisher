defmodule MxPublisherWeb.TrackerControllerTest do
  use MxPublisherWeb.ConnCase

  alias MxPublisher.MxNodes
  alias MxPublisher.MxNodes.Tracker

  @create_attrs %{adress: "some adress", api_key: "some api_key", certificate: "some certificate"}
  @update_attrs %{adress: "some updated adress", api_key: "some updated api_key", certificate: "some updated certificate"}
  @invalid_attrs %{adress: nil, api_key: nil, certificate: nil}

  def fixture(:tracker) do
    {:ok, tracker} = MxNodes.create_tracker(@create_attrs)
    tracker
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trackers", %{conn: conn} do
      conn = get conn, tracker_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tracker" do
    test "renders tracker when data is valid", %{conn: conn} do
      conn = post conn, tracker_path(conn, :create), tracker: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, tracker_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "adress" => "some adress",
        "api_key" => "some api_key",
        "certificate" => "some certificate"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, tracker_path(conn, :create), tracker: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tracker" do
    setup [:create_tracker]

    test "renders tracker when data is valid", %{conn: conn, tracker: %Tracker{id: id} = tracker} do
      conn = put conn, tracker_path(conn, :update, tracker), tracker: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, tracker_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "adress" => "some updated adress",
        "api_key" => "some updated api_key",
        "certificate" => "some updated certificate"}
    end

    test "renders errors when data is invalid", %{conn: conn, tracker: tracker} do
      conn = put conn, tracker_path(conn, :update, tracker), tracker: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tracker" do
    setup [:create_tracker]

    test "deletes chosen tracker", %{conn: conn, tracker: tracker} do
      conn = delete conn, tracker_path(conn, :delete, tracker)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, tracker_path(conn, :show, tracker)
      end
    end
  end

  defp create_tracker(_) do
    tracker = fixture(:tracker)
    {:ok, tracker: tracker}
  end
end
