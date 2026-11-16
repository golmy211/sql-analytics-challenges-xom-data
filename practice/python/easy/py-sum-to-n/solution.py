# Xom Data · Add up the day's slip numbers
# Problem: https://xomdata.com/practice/py-sum-to-n
# Solved: 2026-11-15

def sum_to(n):
    total = 0
    for x in range(1,n+1):
        total += x 
    return total
