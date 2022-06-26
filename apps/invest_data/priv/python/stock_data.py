import yfinance as yf
from datetime import datetime
# Stock data


def fetch_stock_price(symbol):
    start_date = datetime(2022, 6, 20)
    end_date = datetime(2021, 1, 1)
    data = yf.download(symbol, start=start_date)
    result = data.to_json(orient='index')
    return result
# fetch_stock_price("INTC")