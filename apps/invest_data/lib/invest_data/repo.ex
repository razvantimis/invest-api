defmodule InvestData.Repo do
  use Mongo.Repo,
    otp_app: :invest_data,
    topology: :mongo

  @dialyzer :no_match
end
