defmodule SuperApiWeb.TeacherController do
  use SuperApiWeb, :controller

  alias SuperApi.School
  alias SuperApi.School.Teacher

  action_fallback SuperApiWeb.FallbackController

  def index(conn, _params) do
    teachers = School.list_teachers()
    render(conn, "index.json", teachers: teachers)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    with {:ok, %Teacher{} = teacher} <- School.create_teacher(teacher_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", teacher_path(conn, :show, teacher))
      |> render("show.json", teacher: teacher)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = School.get_teacher!(id)
    render(conn, "show.json", teacher: teacher)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = School.get_teacher!(id)

    with {:ok, %Teacher{} = teacher} <- School.update_teacher(teacher, teacher_params) do
      render(conn, "show.json", teacher: teacher)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = School.get_teacher!(id)
    with {:ok, %Teacher{}} <- School.delete_teacher(teacher) do
      send_resp(conn, :no_content, "")
    end
  end
end
