import time

replacements = []

medicine = None

for line in open("../inputs/day-19.txt"):
    parts = line.strip().split(" => ")
    if len(parts) == 1:
        if not line.strip():
            continue
        medicine = line.strip()
        continue
    replacements.append((parts[0], parts[1]))


def part1():
    molecules = set()
    for src, repl in replacements:
        idx = 0
        while True:
            idx = medicine.find(src, idx+1)
            if idx == -1:
                break
            molecules.add(medicine[:idx] + repl + medicine[idx + len(src):])
    return len(molecules)


def part2():
    med = medicine
    count = 0
    while med != 'e':
        for src, repl in replacements:
            if repl in med:
                med = med.replace(repl, src, 1)
                count +=1
    return count

if __name__ == '__main__':
    now = time.time()
    print "Part 1: ", part1(),
    print "in", int((time.time() - now) * 1000000), "microseconds"
    now = time.time()
    print "Part 2: ", part2(),
    print "in", int((time.time() - now) * 1000000), "microseconds"