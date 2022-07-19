defmodule InvestWeb.Graphql.Resolvers.Stock do
  alias InvestData
  def get_last_stock_price(_obj, %{:symbols => symbols}, _ctx) do
    InvestData.fetch_stock_price(symbols)
  end
end
