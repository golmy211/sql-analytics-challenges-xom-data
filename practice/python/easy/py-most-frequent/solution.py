# Xom Data · Most frequent character
# Problem: https://xomdata.com/practice/py-most-frequent
# Solved: 2026-11-08

def most_frequent(text):
    best_char = text[0]
    best_count = text.count(best_char)
    for n in text:
        if text.count(n) > best_count:
            best_char = n
    return best_char
