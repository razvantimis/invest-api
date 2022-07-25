defmodule InvestData.StockScraper.UsStock do
  require Logger

  @doc """
    Fetch last 7 days stock price
    InvestData.UsStockScraper.fetch_stock_price("MMM")
  """
  def fetch_stock_price(symbol) do
    try do
      case YahooFinance.Quote.get_simple_quote(symbol) do
        {:error, _} ->
          Logger.error("[fetch_stock_price] Error  #{symbol}...")
          {:error, []}

        {:ok, {_symbol, result}} ->
          results = Jason.decode!(result) |> Map.get("quoteResponse") |> Map.get("result")
          cond do
            Enum.count(results) > 0 ->
              [result | _] = results

              stock_price = %{
                date: Date.utc_today(),
                price: result |> Map.get("regularMarketPrice")
              }

              {:ok, [stock_price]}

            Enum.empty?(results) ->
              {:error, []}
          end
      end
    rescue
      e ->
        Logger.error(Exception.format(:error, e, __STACKTRACE__))
        {:error, []}
    end
  end
end
