defmodule SuperApiWeb.TeacherView do
  use SuperApiWeb, :view
  alias SuperApiWeb.TeacherView

  def render("index.json", %{teachers: teachers}) do
    %{data: render_many(teachers, TeacherView, "teacher.json")}
  end

  def render("show.json", %{teacher: teacher}) do
    %{data: render_one(teacher, TeacherView, "teacher.json")}
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{id: teacher.id,
      name: teacher.name,
      age: teacher.age}
  end
end
