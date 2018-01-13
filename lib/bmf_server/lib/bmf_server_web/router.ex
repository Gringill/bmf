defmodule BmfServerWeb.Router do
  use BmfServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BmfServerWeb do
    pipe_through :api
  end
end
