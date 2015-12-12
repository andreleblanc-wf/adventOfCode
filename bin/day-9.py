from collections import defaultdict

import itertools
import sys
import time


distances = defaultdict(dict)

for line in open("../inputs/day-9.txt"):
    l, r = line.strip().split(" = ")
    c1, c2 = l.split(" to ")
    distances[c1][c2] = int(r)
    distances[c2][c1] = int(r)

best = sys.maxint
worst = 0

now = time.time()
for perm in itertools.permutations(distances.keys(), len(distances)):
    dist = 0
    start = perm[0]
    for city in perm[1:]:
        dist += distances[start][city]
        start = city
    if dist < best:
        best = dist
    if dist > worst:
        worst = dist

print best
print worst
print (time.time() - now) * 1000
