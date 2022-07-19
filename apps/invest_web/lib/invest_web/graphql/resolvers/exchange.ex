defmodule InvestWeb.Graphql.Resolvers.Exchange do
  def get_currecy_exchange_rates(_obj, _args, _ctx) do
    IO.puts "test"
    InvestData.fetch_exchange_rates()
  end
end
