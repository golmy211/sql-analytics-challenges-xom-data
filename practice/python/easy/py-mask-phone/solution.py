# Xom Data · Mask phone number
# Problem: https://xomdata.com/practice/py-mask-phone
# Solved: 2026-11-12

def mask_phone(phone):
    if len(phone) <= 3:
        return phone 
    else:
        return "*" * (len(phone)- 3) + phone[-3:]
