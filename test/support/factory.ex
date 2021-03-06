defmodule Blogit.Factory do
  use ExMachina.Ecto, repo: Blogit.Repo

  alias Blogit.Role
  alias Blogit.User
  alias Blogit.Post
  alias Blogit.Comment

  def factory(:role) do
    %Role{
      name: sequence(:name, &"Test Role #{&1}"),
      admin: false
    }
  end

  def factory(:user) do
    %User{
      username: sequence(:username, &"User #{&1}"),
      email: "test@test.com",
      password: "test1234",
      password_confirmation: "test1234",
      password_digest: Comeonin.Bcrypt.hashpwsalt("test1234"),
      role: build(:role)
    }
  end

  def factory(:post) do
    %Post{
      title: "Some Post",
      body: "And the body of some post",
      user: build(:user)
    }
  end

  def factory(:comment) do
    %Comment{
      author: "Test User",
      body: "This is a sample commment",
      approved: false,
      post: build(:post)
    }
  end
end
