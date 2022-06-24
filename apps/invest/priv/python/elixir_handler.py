from erlport.erlang import set_message_handler, cast
from erlport.erlterms import Atom
import stock_data

message_handler = None


def cast_message(pid, message):
    cast(pid, message)


def handle_message(args):
    if message_handler:
        symbol_utf8 = args.decode("utf-8")
        result = stock_data.fetch_stock_price(symbol_utf8)
        cast_message(message_handler, (Atom(b'python'), result))


def register_handler(pid):
    global message_handler
    message_handler = pid


set_message_handler(handle_message)
#  Invest.PythonServer.cast_function("MSFT")