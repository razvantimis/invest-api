defmodule InvestWeb.ApiController do
  use InvestWeb, :controller

  @doc """
     symbols will transform "(BVB:TLV),(US:MMM)" in array of object
  """
  def fetch_stock_price(conn, %{"symbols" => symbols}) do
    symbols_parsed =
      symbols
      |> parse_symbols
    {:ok, result} = InvestData.fetch_stock_price(symbols_parsed)
    json(conn, result)
  end

  def fetch_exchange_rates(conn, %{}) do
    {:ok, result} = InvestData.fetch_exchange_rates()
    json(conn, result)
  end

  defp parse_symbols(symbols) do
    symbols
    |> String.split(",")
    |> Enum.map(&InvestData.StockUtils.parse_symbol(&1))
  end
end
