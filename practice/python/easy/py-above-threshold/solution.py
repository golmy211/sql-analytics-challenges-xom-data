# Xom Data · Count students above the benchmark
# Problem: https://xomdata.com/practice/py-above-threshold
# Solved: 2026-11-08

def count_above(numbers, threshold):
    count = 0
    for n in numbers:
        if n > threshold:
            count += 1 
    return count
