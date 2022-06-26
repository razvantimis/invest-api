import stock_data

def fetch_stock_price(symbol):
    if isinstance(symbol, bytes):
        symbol = symbol.decode("utf-8")
    result = stock_data.fetch_stock_price(symbol)
    return result
