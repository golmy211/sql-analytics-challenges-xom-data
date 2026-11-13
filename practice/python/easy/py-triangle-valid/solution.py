# Xom Data · Check triangle sides
# Problem: https://xomdata.com/practice/py-triangle-valid
# Solved: 2026-11-13

def is_triangle(a, b, c):
    if a + b > c and a + c > b and b + c > a:
        return True
    return False
