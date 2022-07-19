defmodule InvestData.CurrencyExchange.Scrapper do
  import SweetXml

  def fetch_last_currency_exchange_rates() do
    web_page = fetch_web_page()

    {:ok, date} =
      web_page
      |> xpath(~x"//Cube/Cube/@time"s)
      |> Timex.parse!("%Y-%m-%d", :strftime)
      |> DateTime.from_naive("Etc/UTC")

    currency_rates =
      web_page |> xpath(~x"//Cube/Cube"l, currency: ~x"./@currency"S, rate: ~x"./@rate"F)

    result =
      currency_rates
      |> Enum.filter(&(&1.currency != ""))
      |> Enum.map(fn rate -> Map.put(rate, :date, date) end)

    {:ok, result}
  end

  defp fetch_web_page() do
    url = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"

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
end
