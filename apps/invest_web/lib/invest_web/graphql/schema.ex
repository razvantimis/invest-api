defmodule InvestWeb.Schema do
  use Absinthe.Schema

  import_types(InvestWeb.Graphql.Schema.Types)
  import_types(Absinthe.Type.Custom)

  alias InvestWeb.Graphql.Resolvers

  query do
    @desc "Get last stock price"
    field :last_stock_price, list_of(:stock_price) do
      arg :symbols, non_null(list_of(:stock_symbol_input))
      resolve &Resolvers.Stock.get_last_stock_price/3
    end
  end
end
