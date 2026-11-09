# Xom Data · Check safe temperature
# Problem: https://xomdata.com/practice/py-in-range
# Solved: 2026-11-09

def in_range(value, low, high):
    if low <= value <= high:
        return "True"
    else:
        return "False"
