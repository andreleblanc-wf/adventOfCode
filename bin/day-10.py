from itertools import groupby
import time
'''
code-golf aside, this is IMO the pythonic solution, but it's slow.

see the dart version's lookSay2 for an uglier, but much more performant version.

'''

_input = "1113122113"

def look_say(_i):
    return ''.join("{}{}".format(len(list(g)), k) for k, g in groupby(_i))

now = time.time()

for i in range(50):
    _input = look_say(_input)

elapsed = (time.time() - now) * 1000

print len(_input)
print "Time: %s:" % (elapsed,)
