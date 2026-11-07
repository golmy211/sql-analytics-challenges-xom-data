# Xom Data · Highest price in the list
# Problem: https://xomdata.com/practice/py-max-price
# Solved: 2026-11-07

def highest_price(prices):
    if not prices:
        return "0"
    return max(prices)
