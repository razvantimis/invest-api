defmodule InvestWeb.PageController do
  use InvestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
