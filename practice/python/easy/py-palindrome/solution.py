# Xom Data · Check palindrome
# Problem: https://xomdata.com/practice/py-palindrome
# Solved: 2026-11-07

def is_palindrome(text):
    text = text.lower()
    return text == text[::-1]
