defmodule SuperApiWeb.TeacherControllerTest do
  use SuperApiWeb.ConnCase

  alias SuperApi.School
  alias SuperApi.School.Teacher

  @create_attrs %{age: 42, name: "some name"}
  @update_attrs %{age: 43, name: "some updated name"}
  @invalid_attrs %{age: nil, name: nil}

  def fixture(:teacher) do
    {:ok, teacher} = School.create_teacher(@create_attrs)
    teacher
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teachers", %{conn: conn} do
      conn = get conn, teacher_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teacher" do
    test "renders teacher when data is valid", %{conn: conn} do
      conn = post conn, teacher_path(conn, :create), teacher: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, teacher_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "age" => 42,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, teacher_path(conn, :create), teacher: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teacher" do
    setup [:create_teacher]

    test "renders teacher when data is valid", %{conn: conn, teacher: %Teacher{id: id} = teacher} do
      conn = put conn, teacher_path(conn, :update, teacher), teacher: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, teacher_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "age" => 43,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, teacher: teacher} do
      conn = put conn, teacher_path(conn, :update, teacher), teacher: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teacher" do
    setup [:create_teacher]

    test "deletes chosen teacher", %{conn: conn, teacher: teacher} do
      conn = delete conn, teacher_path(conn, :delete, teacher)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, teacher_path(conn, :show, teacher)
      end
    end
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    {:ok, teacher: teacher}
  end
end
