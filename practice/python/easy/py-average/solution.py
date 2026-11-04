# Xom Data · Average score by subject
# Problem: https://xomdata.com/practice/py-average
# Solved: 2026-11-04

def average_score(scores):
    if len(scores) == 0:
        return 0
    total = 0
    for n in scores:
        total += n 
    return round(total/len(scores),2)
