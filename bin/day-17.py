from itertools import combinations
import time

# Not parsing input for this one, its too short and simple.
containers = [43, 3, 4, 10, 21, 44, 4, 6, 47, 41,
              34, 17, 17, 44, 36, 31, 46, 9, 27, 38]

#part 1
now = time.time()
combos = 0
for count in range(1, len(containers) + 1):
    combos += len([c for c in combinations(containers, count) if sum(c) == 150])
print "Part 1:", combos, "in", int((time.time() - now) * 1000), "ms"

# part 2
now = time.time()
for_size = None
for count in range(1, len(containers) + 1):
    for_size = len([c for c in combinations(containers, count) if sum(c) == 150])
    if for_size:
        break
print "Part 1:", for_size, "in", int((time.time() - now) * 1000), "ms"


