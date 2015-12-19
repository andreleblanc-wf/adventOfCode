import re
import time

parser = re.compile(r'Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)')
sues = {}
for line in open("../inputs/day-16.txt"):
    m = parser.match(line)
    sue = {
        m.group(2): int(m.group(3)),
        m.group(4): int(m.group(5)),
        m.group(6): int(m.group(7)),
    }
    sues[m.group(1)] = sue

search = {
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
}

def _matches(search, data):
    for k, v in data.iteritems():
        if search[k] != v:
            return False
    return True


def _matches2(search, data):
    for k, v in data.iteritems():
        if k in ('cats', 'trees'):
            if search.get(k) >= v:
                return False
        elif k in ('pomeranians', 'goldfish'):
            if search.get(k) <= v:
                return False
        elif search.get(k, None) != v:
            return False
    return True

now = time.time()
match = None
for sue, data in sues.iteritems():
    if _matches(search, data):
        match = sue
        break

print '#1 Sue #%s in %s microseconds' % (match, (time.time() - now) * 1000000)

now = time.time()
match = None
for sue, data in sues.iteritems():
    if _matches2(search, data):
        match = sue
        break

print '#2 Sue #%s in %s microseconds' % (match, (time.time() - now) * 1000000)