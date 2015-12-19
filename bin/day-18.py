import time

lines = [l.strip() for l in open("../inputs/day-18.txt")]

# for evolve
# stuck_lights = set([(0,0), (99, 0), (0, 99), (99,99)])
# for evolve_optimized
stuck_lights = set([0, 99, 9999, 9900])

now = time.time()
lights = set()
for y, line in enumerate(lines):
    for x, char in enumerate(line):
        if char == '#':
            # for 'evolve'
            # lights.add((x, y))
            # for 'evolve_optimized'
            lights.add((y*100)+x)

lights = lights.union(stuck_lights)

def evolve(state, initial_state):
    '''
    This is the un-optimized 'pythonic' version. its kinda slow.
    to run it you need to add (x, y) tuples to 'lights' in the
    initialization code above.
    '''
    new_state = set(initial_state)
    for x in xrange(0, 100):
        for y in xrange(0, 100):
            lit_neighbours = len([l for l in [(x-1, y-1), (x-1, y), (x-1, y+1),
                                              (x, y-1), (x, y+1),
                                              (x+1, y-1), (x+1, y), (x+1, y+1)] if l in state])
            if (x, y) in state:
                if lit_neighbours in (2,3):
                    new_state.add((x,y))
            else:
                if lit_neighbours == 3:
                    new_state.add((x,y))
    return new_state


def evolve_optimized(state, initial_state):
    '''
    Replacing the x,y tuples with ints (y*100+x) is a significant speedup
    but adds the complexity of having to do bounds checking everywhere.
    Earlying out as soon as lit_neighbours exceeds 3 was considered, but
    offered no performance benefit.

    '''
    new_state = set(initial_state)
    for i in xrange(10000):
        y = i / 100
        x = i % 100
        lit_neighbours = 0
        if x != 0:
            if y != 0 and i-101 in state:
                lit_neighbours += 1
            if y != 99 and i+99 in state:
                lit_neighbours += 1
            if i-1 in state:
                lit_neighbours += 1
        if x != 99:
            if y != 0 and i-99 in state:
                lit_neighbours += 1
            if y != 99 and i+101 in state:
                lit_neighbours += 1
            if i+1 in state:
                lit_neighbours += 1
        if y != 0 and i-100 in state:
            lit_neighbours += 1
        if y != 99 and i+100 in state:
            lit_neighbours += 1

        if i in state:
            if lit_neighbours in (2,3):
                new_state.add(i)
        else:
            if lit_neighbours == 3:
                new_state.add(i)
    return new_state


state = lights
for i in range(100):
    state = evolve_optimized(state, set([0, 99, 9900, 9999]))

print len(state)
print ((time.time() - now) * 1000)
