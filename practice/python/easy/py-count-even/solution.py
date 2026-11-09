# Xom Data · Count products with an even code
# Problem: https://xomdata.com/practice/py-count-even
# Solved: 2026-11-09

def count_even(numbers):
    count = 0
    for n in numbers:
        if n % 2 == 0: 
            count += 1 
    return count
