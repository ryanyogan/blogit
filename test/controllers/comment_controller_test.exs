
defmodule Blogit.CommentControllerTest do
  use Blogit.ConnCase

  alias Blogit.Factory

  @valid_attrs %{author: "Some Person", body: "This is a simple comment"}
  @invalid_attrs %{}

  setup do
    user = Factory.create(:user)
    post = Factory.create(:post, user: user)

    {:ok, conn: conn, user: user, post: post}
  end

  test "creates resource and redirects when data is valid", %{conn: conn, post: post} do
    _conn = post conn, post_comment_path(conn, :create, post), comment: @valid_attrs
    assert Repo.get_by(assoc(post, :comments), @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, post: post} do
    conn = post conn, post_comment_path(conn, :create, post), comment: @invalid_attrs
    assert html_response(conn, 200) =~ "Oops, something went wrong"
  end
end
