import re
from collections import defaultdict

import time

parser = re.compile(r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+)')
deer = {}

def deer_at_time(t, speed, duration, rest):

    action_seconds_remaining = duration
    resting = False
    distance = 0

    while t > 0:
        t -= 1
        action_seconds_remaining -= 1
        if not resting:
            distance += speed
        yield distance
        if action_seconds_remaining == 0:
            resting = not resting
            if resting:
                action_seconds_remaining = rest
            else:
                action_seconds_remaining = duration


for line in open("../inputs/day-14.txt"):
    m = parser.match(line)
    deer[m.groups()[0]] = (int(m.groups()[1]), int(m.groups()[2]), int(m.groups()[3]))


# part 1
now = time.time()
bestDist = 0
for d in deer:
    dist = list(deer_at_time(2503, *deer[d]))[-1]
    if dist > bestDist:
        bestDist = dist
print '#1', bestDist, 'in', int((time.time() - now) * 1000), 'ms'

# part 2
now = time.time()
points = defaultdict(int)
deer_names = list(deer.keys())
generators = [deer_at_time(2503, *deer[d]) for d in deer_names]
for tick in zip(*generators):
    best_score = max(list(tick))
    for i, dist in enumerate(tick):
        if dist == best_score:
            points[deer_names[i]] += 1

print '#2', max(points.values()), 'in', int((time.time() - now) * 1000), 'ms'



