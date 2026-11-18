# Xom Data · Alternate-merge two lists
# Problem: https://xomdata.com/practice/py-merge-alternate
# Solved: 2026-11-18

def merge_alternate(list1, list2):
    merge = []
    for i in range(max(len(list1),len(list2))):
        if i < len(list1):
            merge.append(list1[i])
        if i < len(list2):
            merge.append(list2[i])
    return merge
