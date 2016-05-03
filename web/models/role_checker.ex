defmodule Blogit.RoleChecker do
  alias Blogit.Repo
  alias Blogit.Role

  def is_admin?(user) do
    (role = Repo.get(Role, user.role_id)) && role.admin
  end
end
