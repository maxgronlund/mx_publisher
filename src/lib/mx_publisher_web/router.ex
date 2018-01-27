defmodule MxPublisherWeb.Router do
  use MxPublisherWeb, :router
  alias MxPublisher.Repo
  alias MxPublisher.Accounts.User

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MxPublisherWeb.Auth, repo: User.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MxPublisherWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/publishers", PublisherController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/users", UserController
    resources "/trackers", TrackerController

  end

  # Other scopes may use custom stacks.
  scope "/api", MxPublisherWeb do
    pipe_through :api
    resources "/mx_trackers", MxTrackerController, except: [:new, :edit]
  end
end
