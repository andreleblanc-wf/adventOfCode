import itertools
import operator
import time

ingredients = []
import re

parser = re.compile("\w+: \w+ (\-?\d+), \w+ (\-?\d+), \w+ (\-?\d+), \w+ (\-?\d+), \w+ (\-?\d+)")

for line in open("../inputs/day-15.txt"):
    m = parser.match(line)
    ingredients.append(dict(zip(['capacity', 'durability', 'flavor', 'texture', 'calories'], [int(g) for g in m.groups()])))

print ingredients

now = time.time()
def sum_permutations(size, target):
    if size == 1:
        yield(target,)
    else:
        for i in xrange(target+1):
            for val in sum_permutations(size-1, target-i):
                yield (i,) + val

perms = list(sum_permutations(4, 100))
print len(perms), 'in', ((time.time() - now) * 1000), 'ms'

def compute_score_1(counts):
    values = {}
    for attr in ['capacity', 'durability', 'flavor', 'texture']:
        values[attr] = 0
        for i, c in enumerate(counts):
            if c > 0:
                values[attr] += ingredients[i][attr]*c
        if values[attr] <= 0:
            values[attr] = 0

    return reduce(operator.mul, values.values(), 1)


def compute_score_2(counts):
    values = {}
    for attr in ['calories', 'capacity', 'durability', 'flavor', 'texture']:
        values[attr] = 0
        for i, c in enumerate(counts):
            if c > 0:
                values[attr] += ingredients[i][attr]*c
        if values[attr] <= 0:
            values[attr] = 0
        if attr == 'calories' and values['calories'] != 500:
            return -1

    values = [v for k, v in values.iteritems() if k != 'calories']
    return reduce(operator.mul, values, 1)

now = time.time()
best_score = 0
for perm in perms:
    score = compute_score_1(perm)
    if score > best_score:
        best_score = score
print "#1", best_score, int((time.time() - now) * 1000), 'ms'

now = time.time()
best_score = 0
for perm in perms:
    score = compute_score_2(perm)
    if score > best_score:
        best_score = score
print "#2", best_score, int((time.time() - now) * 1000), 'ms'
