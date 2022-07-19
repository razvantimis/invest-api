defmodule InvestData.StockUtils do
  def create_symbol(%{exchange: exchange, symbol: symbol}) do
    normalize_exchange = exchange |> String.upcase()
    normalize_symbol = symbol |> String.upcase()
    "#{normalize_exchange}:#{normalize_symbol}"
  end

  @spec parse_symbol(binary()) :: %{:exchange => binary(), :symbol => binary()}
  def parse_symbol(symbol) do
    symbol
    |> String.replace(["(", ")"], "")
    |> String.split(":")
    |> then(fn [exchange, symbol] -> %{exchange: exchange, symbol: symbol} end)
  end
end
