defmodule InvestData.Entities.CurrencyExchangeRate do
  use Mongo.Collection
  @collection nil
  @id nil

  collection "currencyExchangeRate" do
    attribute(:from_currency, String.t())
    attribute(:to_Currency, String.t())
    attribute(:date, DateTime.t())
    attribute(:rate, Decimal.t())
  end

  def new(from_currency, to_currency, date, rate) do
    new()
    |> Map.put(:from_currency, from_currency)
    |> Map.put(:to_currency, to_currency)
    |> Map.put(:date, date)
    |> Map.put(:rate, rate)
  end


end
