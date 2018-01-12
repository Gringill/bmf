defmodule BmfClientWeb.Router do
  use BmfClientWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BmfClientWeb do
    pipe_through :api
  end
end
