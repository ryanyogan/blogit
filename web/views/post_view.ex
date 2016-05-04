defmodule Blogit.PostView do
  use Blogit.Web, :view

  def markdown(body) do
    body
    |> Earmark.to_html
    |> raw
  end
end
