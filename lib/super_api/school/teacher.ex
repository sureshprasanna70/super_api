defmodule SuperApi.School.Teacher do
  use Ecto.Schema
  import Ecto.Changeset


  schema "teachers" do
    field :age, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
