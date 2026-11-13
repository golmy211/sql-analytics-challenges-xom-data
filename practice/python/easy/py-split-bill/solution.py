# Xom Data · Split a bill into whole dong
# Problem: https://xomdata.com/practice/py-split-bill
# Solved: 2026-11-13

def split_bill(total, people):
    total, people = divmod(total,people)
    return total,people
