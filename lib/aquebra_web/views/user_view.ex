defmodule AquebraWeb.UserView do
  use AquebraWeb, :view
  alias AquebraWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      type: user.type,
      firebaseId: user.firebaseId
    }
  end
end
