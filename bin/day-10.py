from itertools import groupby
import time
import re

_input = "1113122113"

def look_say(_i):
    return ''.join("{}{}".format(len(list(g)), k) for k, g in groupby(_i))

def look_say_2(_i):
    return ''.join("{}{}".format(len(m.group()), m.group()[0]) for m in re.finditer(r'(\d)\1*', _i))

now = time.time()

for i in range(50):
    _input = look_say(_input)

elapsed = (time.time() - now) * 1000

print len(_input)
print "Time: %s:" % (elapsed,)
