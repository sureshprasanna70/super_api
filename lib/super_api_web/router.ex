defmodule SuperApiWeb.Router do
  use SuperApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SuperApiWeb do
    pipe_through :api
    resources "/teachers", TeacherController, except: [:new, :edit]
  end
end
