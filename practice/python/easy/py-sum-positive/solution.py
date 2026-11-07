# Xom Data · Total receipts
# Problem: https://xomdata.com/practice/py-sum-positive
# Solved: 2026-11-07

def sum_positive(numbers):
    total = 0
    for n in numbers:
        if n > 0:
            total += n 
    return total
