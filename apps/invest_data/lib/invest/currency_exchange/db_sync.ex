defmodule InvestData.CurrencyExchange.DBSync do
  @moduledoc """
    Sync between DB and price from web scraper
  """
  require Logger
  alias InvestData.{Repo, Entities.CurrencyExchangeRate, CurrencyExchange.Scrapper}

  def fetch_currency_exchange_rates() do
    currency_exchange_rates_db = get_currency_exchange_rate_from_db()

    case Enum.count(currency_exchange_rates_db) do
      0 ->
        {:ok, rates_prepared} = polling_currency_exchange_rates()
        result = rates_prepared |> Enum.map(&Map.delete(&1, :_id))
        {:ok, result}

      _ ->
        result =
          currency_exchange_rates_db
          |> Enum.map(&CurrencyExchangeRate.dump(&1))
          |> Enum.map(&Map.delete(&1, :_id))

        {:ok, result}
    end
  end

  def polling_currency_exchange_rates() do
    {:ok, rates} = Scrapper.fetch_last_currency_exchange_rates()

    rates_prepared =
      rates
      |> Enum.map(&CurrencyExchangeRate.new("EUR", &1.currency, &1.date, &1.rate))
      |> Enum.map(&CurrencyExchangeRate.dump(&1))

    if Enum.count(rates_prepared) > 0 do
      Repo.insert_all(CurrencyExchangeRate, rates_prepared, ordered: false)
    end

    {:ok, rates_prepared}
  end

  defp get_currency_exchange_rate_from_db() do
    today = DateTime.utc_now()
    start_date = today |> DateTime.add(-7 * 60 * 60 * 24, :second)

    Repo.aggregate(CurrencyExchangeRate, [
      %{
        "$match" => %{
          date: %{
            "$gte": start_date,
            "$lte": today
          }
        }
      },
      %{"$sort" => [{"date", -1}]}
    ])
  end
end
