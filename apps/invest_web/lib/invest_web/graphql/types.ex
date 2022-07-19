defmodule InvestWeb.Graphql.Schema.Types do
  use Absinthe.Schema.Notation

  object :stock_price do
    field :symbol, :string
    field :date, :datetime
    field :price, :float
  end

  enum :country_type do
    value :RO, as: "RO"
    value :US, as: "US"
  end

  input_object :stock_symbol_input do
    field :symbol, non_null(:string)
    field :country, non_null(:country_type)
  end


end
