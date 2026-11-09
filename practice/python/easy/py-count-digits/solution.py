# Xom Data · Count digits in the password
# Problem: https://xomdata.com/practice/py-count-digits
# Solved: 2026-11-09

def count_digits(text):
    count = 0
    for n in text:
        if n.isdigit():
            count += 1 
    return count
