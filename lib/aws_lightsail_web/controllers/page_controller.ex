defmodule AwsLightsailWeb.PageController do
  use AwsLightsailWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
