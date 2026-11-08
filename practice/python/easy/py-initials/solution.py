# Xom Data · Generate initials
# Problem: https://xomdata.com/practice/py-initials
# Solved: 2026-11-08

def get_initials(full_name):
    result = " "
    for n in full_name.split():
        result += n[0].upper()
    return result
