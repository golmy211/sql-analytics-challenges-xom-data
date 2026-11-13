# Xom Data · Sum of digits in the code
# Problem: https://xomdata.com/practice/py-digit-sum
# Solved: 2026-11-12

def digit_sum(number):
    total = 0
    for n in str(number):
        total += int(n)  
    return total
