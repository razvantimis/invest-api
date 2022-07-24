defmodule InvestData.Entities.StockPrice do
  use Mongo.Collection
  alias InvestData.StockUtils

  @collection nil
  @id nil

  collection "stockPrice" do
    attribute(:symbol, String.t())
    attribute(:date, DateTime.t())
    attribute(:price, Decimal.t())
  end

  def new(symbol, date, price) do
    new()
    |> Map.put(:symbol, StockUtils.create_symbol(symbol))
    |> Map.put(:date, date)
    |> Map.put(:price, price)
  end


end
