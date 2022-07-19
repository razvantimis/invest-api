defmodule InvestData.StockScraper.BvbStock do
  defp fetch_stock_page(symbol) do
    url =
      "https://www.bvb.ro/FinancialInstruments/Details/FinancialInstrumentsDetails.aspx?s=#{symbol}"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case response.status_code do
          200 -> response.body
          _ -> :error
        end

      _ ->
        :error
    end
  end

  @doc """
  Fetch bvb last stock price
  """
  def fetch_stock_price(symbol) do
    {:ok, document} = fetch_stock_page(symbol) |> Floki.parse_document()

    rows =
      document
      |> Floki.find("#ctl00_body_ctl02_PricesControl_dvCPrices tr")
      |> Enum.map(&parse_table_row(&1))

    stock_price =
      rows
      |> Enum.find(fn item -> item.name == "Last price" end)
      |> Map.get(:value)
      |> String.to_float()

    stock_date =
      rows
      |> Enum.find(fn item -> item.name == "Date/time" end)
      |> Map.get(:value)
      |> Timex.parse("%M/%D/%Y", :strftime)

    stock_price_list = [
      %{
        date: Date.utc_today(),
        price: stock_price
      }
    ]

    {:ok, stock_price_list}
  end

  defp parse_table_row(row) do
    {_, _, tds} = row
    [name_td, value_td] = tds
    name_text = name_td |> Floki.text()
    value_text = value_td |> Floki.text()

    %{
      name: name_text,
      value: value_text
    }
  end
end
