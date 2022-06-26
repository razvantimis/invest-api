defmodule InvestData.PythonApi do
  alias InvestData.PythonWorker

  def fetch_stock_price(symbol) do
    case PythonWorker.call(:fetch_stock_price, symbol) do
      {:ok, response} -> Jason.decode!(response)
    end
  end
end
