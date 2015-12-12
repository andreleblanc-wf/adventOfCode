import re
import string
import time

'''
Given an initial password, 'increment' it until it 'is_valid'

'''

# builds a list of ['abc', 'bcd', 'cde', ...etc...]
valid_triplets = ["%s%s%s" % (c, chr(ord(c)+1), chr(ord(c)+2)) for c in string.lowercase[:-2]]

#matches 2 double letters. (eg. "aaxyzbbcde")
pair_re = re.compile(r'(\w)\1.*(\w)\2')


def increment(pw):
    '''
    incrementing a string is increasing the last letter (eg. a->b, b->c, etc)
    unless it's z, in which case, it becomes a, and you increment the rest
    of the string recursively.

    '''
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