# Xom Data · Lowest price in the quote
# Problem: https://xomdata.com/practice/py-min-value
# Solved: 2026-11-08

def smallest(numbers):
    if not numbers:
        return 0 
    minn = numbers[0]
    for n in numbers:
        if n < minn:
            minn = n 
    return minn
