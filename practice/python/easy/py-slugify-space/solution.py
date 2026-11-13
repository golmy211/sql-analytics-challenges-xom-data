# Xom Data · Turn a title into a friendly URL part
# Problem: https://xomdata.com/practice/py-slugify-space
# Solved: 2026-11-13

def to_slug(title):
    return title.lower().replace(' ', '-')
