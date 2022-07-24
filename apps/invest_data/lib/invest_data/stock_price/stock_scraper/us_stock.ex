defmodule InvestData.StockScraper.UsStock do
  require Logger

  @doc """
    Fetch last 7 days stock price
    InvestData.UsStockScraper.fetch_stock_price("MMM")
  """
  def fetch_stock_price(symbol) do
    today = Date.utc_today()
    start_date = Date.add(today, -7) |> format_date
    end_date = today |> format_date
    {:ok, result} = fetch_stock_price(symbol, start_date, end_date)
    {:ok, result}
  end

  def fetch_stock_price(symbol, start_date, end_date) do
    case YahooFinance.historical(symbol, start_date, end_date) do
      {:error, _} ->
        Logger.error("[fetch_stock_price] Error  #{symbol}...")
        {:error, []}

      {:ok, {_, [history]}} ->
        # column: "Date", "Open", "High", "Low", "Close", "Adj Close", "Volume"
        columns =
          history
          |> String.replace("\n", ",")
          |> String.split(",")
          |> Enum.chunk_every(7)
          |> Enum.slice(1..-1)

        stock_price_list =
          Enum.reduce(columns, [], fn row, acc ->
            {:ok, date} = Date.from_iso8601(Enum.at(row, 0))

            stock_price = %{
              date:  DateTime.new!(date, Time.new!(0, 0, 0, 0)),
              # adj_close
              price: Enum.at(row, 5) |> String.to_float()
              # open: Enum.at(row, 1) |> String.to_float(),
              # close: Enum.at(row, 2) |> String.to_float(),
              # high: Enum.at(row, 3) |> String.to_float(),
              # low: Enum.at(row, 4) |> String.to_float(),
              # adj_close: Enum.at(row, 5) |> String.to_float(),
              # volume: Enum.at(row, 6) |> String.to_integer()
            }

            Enum.concat(acc, [stock_price])
          end)

        {:ok, stock_price_list}
    end
  end

  defp format_date(date) do
    [date.year, date.month, date.day]
    |> Enum.map(&to_string/1)
    |> Enum.map_join("-", &String.pad_leading(&1, 2, "0"))
  end
end
