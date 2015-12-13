import re
from collections import defaultdict

import time
from itertools import permutations

parser = re.compile(r'(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)')

prefs = defaultdict(dict)

for line in open("../inputs/day-13.txt"):
    parts = parser.match(line).groups()
    val = int(parts[2]);
    if parts[1] == 'lose':
        val *= -1
    prefs[parts[0]][parts[3]] = val

# part 2
for person in prefs.keys():
    prefs['Andre'][person] = 0
    prefs[person]['Andre'] = 0

best_change = 0
now = time.time()
for perm in permutations(prefs.keys(), len(prefs.keys())):
    change = 0
    for i, person in enumerate(perm):
        change += prefs[person][perm[i-1]]
        change += prefs[person][perm[i+1 if i < len(perm)-1 else 0]]
    if change > best_change:
        best_change = change

print best_change, "in", (time.time() - now) * 1000, 'ms'


