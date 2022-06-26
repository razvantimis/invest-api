defmodule InvestData.BvbStockPrice do
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
  Fetch bvb stock price
  """
  def fetch_stock_price(symbol) do
    {:ok, document} = fetch_stock_page(symbol) |> Floki.parse_document()
    rows = document |> Floki.find("#ctl00_body_ctl02_PricesControl_dvCPrices tr")

    row = rows
    |> Enum.map(&parse_stock_row(&1))
    |> Enum.find(fn item -> item.name == "Last price" end)

    row.value
  end

  defp parse_stock_row(row) do
    {_, _, tds} = row
    [nameTd, valueTd] = tds
    nameText = nameTd |> Floki.text()
    valueText = valueTd |> Floki.text()

    %{
      name: nameText,
      value: valueText
    }
  end
end
