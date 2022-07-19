defmodule InvestData do
  @moduledoc """

  """
  alias InvestData.{StockDBSync, CurrencyExchange}

  def fetch_stock_price(symbols) do
    StockDBSync.fetch_stock_price(symbols)
  end

  def fetch_exchange_rates() do
    CurrencyExchange.DBSync.fetch_currency_exchange_rates()
  end
end
