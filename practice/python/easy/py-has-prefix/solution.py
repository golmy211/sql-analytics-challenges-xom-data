# Xom Data · Check whether an order belongs to a branch
# Problem: https://xomdata.com/practice/py-has-prefix
# Solved: 2026-11-13

def is_branch_code(code, prefix):
    return code.startswith(prefix)
