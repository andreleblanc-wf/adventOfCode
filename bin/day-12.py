import json

import time

data = json.load(open("../inputs/day-12.txt"))


def sum_digits(o):
    if isinstance(o, list):
        return sum(sum_digits(i) for i in o)
    elif isinstance(o, dict):
        # Comment out for pt1
        if any(v for v in o.values() if v == 'red'):
            return 0
        return sum(sum_digits(v) for v in o.values())
    elif isinstance(o, int):
        return o
    return 0

now = time.time()
print sum_digits(data)
print time.time() - now, 'sec'