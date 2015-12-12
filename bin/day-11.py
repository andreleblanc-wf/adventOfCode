import re
import string
import time


valid_triplets = ["%s%s%s" % (c, chr(ord(c)+1), chr(ord(c)+2)) for c in string.lowercase[:-2]]
pair_re = re.compile(r'(\w)\1.*(\w)\2')


def increment(pw):
    last = pw[-1]
    if last == 'z':
        return increment(pw[:-1]) + 'a'
    return pw[:-1] + chr(ord(last)+1)


def is_valid(pw):
    if 'i' in pw or 'o' in pw or 'l' in pw:
        return False

    if not pair_re.search(pw):
        return False

    for vt in valid_triplets:
        if vt in pw:
            break
    else:
        return False
    return True


password = "hepxcrrq"


now = time.time()
while not is_valid(password):
    password = increment(password)
print password, " took ", int((time.time() - now) * 1000), 'ms'

now = time.time()
password = increment(password)
while not is_valid(password):
    password = increment(password)
print password, " took ", int((time.time() - now) * 1000), 'ms'