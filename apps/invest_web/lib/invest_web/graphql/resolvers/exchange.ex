defmodule InvestWeb.Graphql.Resolvers.Exchange do
  def get_currecy_exchange_rates(_obj, _args, _ctx) do
    InvestData.fetch_exchange_rates()
  end
end
