defmodule BmfWeb.Router do
  use BmfWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BmfWeb do
    pipe_through :api
  end
end
