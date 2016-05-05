defmodule Blogit.Router do
  use Blogit.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Blogit do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController do
      resources "/posts", PostController
    end

    resources "/posts", PostController, only: [] do
      resources "/comments", CommentController, only: [:create, :delete, :update]
    end

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
