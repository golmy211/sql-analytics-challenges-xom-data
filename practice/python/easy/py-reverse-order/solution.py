# Xom Data · Flip the order of the activity log
# Problem: https://xomdata.com/practice/py-reverse-order
# Solved: 2026-11-11

def reverse_order(items):
    if not items:
        return []
    else:
        return items[::-1]
