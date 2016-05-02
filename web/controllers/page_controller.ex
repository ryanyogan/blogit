defmodule Blogit.PageController do
  use Blogit.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
