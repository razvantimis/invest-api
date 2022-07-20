defmodule InvestData.StockScraper do
  @moduledoc """
    Stock scraper data from web
  """
  alias InvestData.StockScraper.{UsStock, BvbStock}

  @spec fetch_stock_price(String.t(), String.t()) :: any()
  def fetch_stock_price(country, symbol) do
    case country do
      "US" -> UsStock.fetch_stock_price(symbol)
      "RO" -> BvbStock.fetch_stock_price(symbol)
      _ -> {:error, []}
    end
  end
end
