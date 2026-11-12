# Xom Data · Ticket price by age
# Problem: https://xomdata.com/practice/py-ticket-price
# Solved: 2026-11-12

def ticket_price(age):
    if age < 6:
        return 0
    elif 6 <= age <=17:
        return 50000
    elif 18 <= age <= 59:
        return 100000
    else:
        return 50000
