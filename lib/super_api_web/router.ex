defmodule SuperApiWeb.Router do
  use SuperApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, [origin: ["*"], headers: ["*"]]
  end

  scope "/api", SuperApiWeb do
    pipe_through :api
    resources "/teachers", TeacherController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    options "/teachers", TeacherController, :nothing
  end
end
