defmodule Blogit.CommentHelperTest do
  use Blogit.ModelCase

  alias Blogit.Comment
  alias Blogit.Factory
  alias Blogit.CommentHelper

  setup do
    user = Factory.create(:user)
    post = Factory.create(:post, user: user)
    comment = Factory.create(:comment, post: post, approved: false)
    fake_socket = %{assigns: %{user: user.id}}

    {:ok, user: user, post: post, comment: comment, socket: fake_socket}
  end

  test "creates a comment for a post", %{post: post} do
    {:ok, comment} = CommentHelper.create(%{"postId" => post.id,
                                            "author" => "Some Person",
                                            "body" => "Some Post"}, %{})
    assert comment
    assert Repo.get(Comment, comment.id)
  end

  test "approves a comment as an authorized user", %{
    post: post, comment: comment, socket: socket} do

    {:ok, comment} = CommentHelper.approve(
      %{"postId" => post.id, "commentId" => comment.id}, socket)
    assert comment.approved
  end

  test "does not approve comment as unauthorized user",
    %{post: post, comment: comment} do

    {:error, message} = CommentHelper.approve(
      %{"postId" => post.id, "commentId" => comment.id}, %{})

    assert message == "User is not authorized"
  end

  test "deletes a comment as authorized user",
    %{post: post, comment: comment, socket: socket} do

    {:ok, comment} = CommentHelper.delete(
      %{"postId" => post.id, "commentId" => comment.id}, socket)

    refute Repo.get(Comment, comment.id)
  end

  test "does not delete comment as unauthorized user", %{post: post, comment: comment} do
    {:error, message} = CommentHelper.delete(
      %{"postId" => post.id, "commentId" => comment.id}, %{})

    assert message == "User is not authorized"
  end
end
