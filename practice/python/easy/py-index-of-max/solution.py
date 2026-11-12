# Xom Data · Position of the priciest item in the table
# Problem: https://xomdata.com/practice/py-index-of-max
# Solved: 2026-11-12

def index_of_max(prices):
    if not prices:
        return -1
    maxx = prices[0]
    for p in prices:
        if p > maxx:
            maxx = p 
    return prices.index(maxx)
