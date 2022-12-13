defmodule AquebraWeb.PageController do
  use AquebraWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
