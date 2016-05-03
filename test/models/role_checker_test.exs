defmodule Blogit.RoleCheckerTest do
  use Blogit.ModelCase
  alias Blogit.TestHelper
  alias Blogit.RoleChecker

  @valid_user %{email: "test@test.com", username: "test", password: "test",
                password_confirmation: "test"}

  test "is_admin? is true when user has an admin role" do
    {:ok, role} = TestHelper.create_role(%{name: "Admin", admin: true})
    {:ok, user} = TestHelper.create_user(role, @valid_user)
    assert RoleChecker.is_admin?(user)
  end

  test "is_admin? is false when user does not have an admin role" do
    {:ok, role} = TestHelper.create_role(%{name: "User", admin: false})
    {:ok, user} = TestHelper.create_user(role, @valid_user)
    refute RoleChecker.is_admin?(user)
  end
end
