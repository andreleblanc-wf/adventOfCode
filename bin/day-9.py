"""
The classic travelling salesman.  distances are only given in one direction,
but it is assumed you can go in either direction.

Since there are only 8 destinations, the brute force solution is the easiest way
and the builtin itertools.permutations takes all the work out of it.
all that's left is summing up the distances and finding the best (and worst for part 2)

"""
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
