#!/bin/env/python
import re

print sum(len(line.strip()) - len(eval(line)) for line in open("day-8.txt"))
print sum(2 + len(re.sub(r'("|\\)', r'\\\1', line.strip())) - len(line.strip()) for line in open("day-8.txt"))
