# Xom Data · Count vowels in a name
# Problem: https://xomdata.com/practice/py-vowels
# Solved: 2026-11-08

def count_vowels(name):
    vowels = ['a','e','i','u','o']
    char = name.lower()
    count = 0
    for n in char:
        if n in vowels:
            count += 1
    return count
