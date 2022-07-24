defmodule InvestData.StockUtils do
  def create_symbol(%{country: country, symbol: symbol}) do
    normalize_country = country |> String.upcase()
    normalize_symbol = symbol |> String.upcase()
    "#{normalize_country}:#{normalize_symbol}"
  end

  @spec parse_symbol(binary()) :: %{:country => binary(), :symbol => binary()}
  def parse_symbol(symbol) do
    symbol
    |> String.replace(["(", ")"], "")
    |> String.split(":")
    |> then(fn [country, symbol] -> %{country: country, symbol: symbol} end)
  end
end
