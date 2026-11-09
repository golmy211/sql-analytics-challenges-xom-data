# Xom Data · Count occurrences of a code
# Problem: https://xomdata.com/practice/py-count-value
# Solved: 2026-11-09

def count_value(items, target):
    count = 0
    for n in items:
        if n == target:
            count += 1
    return count
