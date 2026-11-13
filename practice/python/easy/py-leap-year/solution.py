# Xom Data · Check leap year
# Problem: https://xomdata.com/practice/py-leap-year
# Solved: 2026-11-13

def is_leap_year(year):
    if year % 100 == 0:
        return year % 400 == 0
    elif year % 4 == 0:
        return True 
    else:
        return False
