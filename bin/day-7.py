import time

ops = {
    'OR': lambda a, b: a | b,
    'AND': lambda a, b: a & b,
    'NOT': lambda a: ~a,
    'RSHIFT': lambda a, b: a >> b,
    'LSHIFT': lambda a, b: a << b
}


def evaluate(wire):

    # 'wire' might be a literal value, because we optimistically call
    # evaluate on each operand in the complex expressions
    if isinstance(wire, int):
        return wire
    elif wire.isdigit():
        return int(wire)

    # it's an actual wire, so we're going to look it up in the dict
    # and evaluate whatever we find there.  then we re-assign it to the wire
    # label for other dependent wires to re-use the value without re-evaluating
    # the whole thing
    val = wires[wire]
    if isinstance(val, int):
        # it's an actual number
        return val
    elif val.isdigit():
        # it's a stringified number
        wires[wire] = int(val)
    elif val in wires:
        # it's a wire label
        wires[wire] = evaluate(val)
    else:
        # it's a complex expression, parse and evaluate it's parts
        parts = val.split(' ')
        if len(parts) == 3:
            # a binary operator
            wires[wire] = ops[parts[1]](evaluate(parts[0]), evaluate(parts[2]))
        elif len(parts) == 2:
            # a unary opeartor
            wires[wire] = ops[parts[0]](evaluate(parts[1]))

    return wires[wire]

wires = {}

now = time.time()

for line in open("../inputs/day-7.txt"):
    l, r = line.split(" -> ")
    wires[r.strip()] = l

print evaluate('a'),

print 'in', int((time.time() - now) * 1000000), 'microseconds'