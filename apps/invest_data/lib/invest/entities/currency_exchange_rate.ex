defmodule InvestData.Entities.CurrencyExchangeRate do
  use Mongo.Collection
  @collection nil
  @id nil

  collection "currencyExchangeRate" do
    attribute(:fromCurrency, String.t())
    attribute(:toCurrency, String.t())
    attribute(:date, DateTime.t())
    attribute(:rate, Decimal.t())
  end

  def new(fromCurrency, toCurrency, date, rate) do
    new()
    |> Map.put(:fromCurrency, fromCurrency)
    |> Map.put(:toCurrency, toCurrency)
    |> Map.put(:date, date)
    |> Map.put(:rate, rate)
  end


end
