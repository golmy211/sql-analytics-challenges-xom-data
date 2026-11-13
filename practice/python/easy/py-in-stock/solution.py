# Xom Data · Count in-stock products
# Problem: https://xomdata.com/practice/py-in-stock
# Solved: 2026-11-13

def count_in_stock(quantities):
    count = 0
    for n in quantities:
        if n > 0:
            count += 1 
    return count
