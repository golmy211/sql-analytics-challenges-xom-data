# Xom Data · Letter grade from score
# Problem: https://xomdata.com/practice/py-grade-letter
# Solved: 2026-11-07

def grade_letter(score):
    if score >= 90:
        return "A"
    elif 80 <= score < 90:
        return "B"
    elif  70 <= score < 80:
        return "C"
    elif 60 <= score < 70:
        return "D"
    else: 
        return "F"
