defmodule InvestWeb.PageController do
  use InvestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch_stock_price(conn, %{"symbol" => symbol}) do
    result = InvestData.PythonServer.cast_function(symbol)
    json(conn, result)
  end
end
