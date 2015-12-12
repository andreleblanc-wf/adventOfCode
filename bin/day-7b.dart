import 'dart:io';

Map<String, Function> ops = {
  null: (List<int> inp) => inp[0],
  'NOT': (List<int> inp) => ~inp[0],
  'AND': (List<int> inp) => inp[0] & inp[1],
  'OR': (List<int> inp) => inp[0] | inp[1],
  'RSHIFT': (List<int> inp) => inp[0] >> inp[1],
  'LSHIFT': (List<int> inp) => inp[0] << inp[1],
};


main() {
  RegExp expr = new RegExp(r'(\d+ )?(\w+ )?(\d+)$');
  RegExp varMatch = new RegExp(r'[a-z]+');
  RegExp re = new RegExp(r'^([\w\d\s]+) -> (\w+)$');

  Map<String, dynamic> wires = new Map<String, dynamic>();
  List<String> lines = new File("../inputs/day-7.txt").readAsLinesSync();

  List<String> findDependents(String wire) {
    List<String> results = [];
    RegExp r = new RegExp(r'\b' + wire + r'\b');
    wires.forEach((k, v) {
      if (r.hasMatch(v.toString())) results.add(k);
    });
    return results;
  }

  dynamic evaluate(String key, var val) {
    if (val == null) return null;
    val = val.toString().replaceAllMapped(varMatch, (m) {
      String wire = m.group(0);
      if (wires.containsKey(wire) && wires[wire].runtimeType == int) {
        return wires[wire].toString();
      }
      return wire;
    });

    wires[key] = val;
    Match m = expr.matchAsPrefix(val);
    if (m != null) {
      var res = ops[m.group(2)?.trim()](
          m.groups([1,3])
              .where((g) => g != null)
              .map((g) => int.parse(g.trim()))
              .toList());

      res = res < 0 ? 65536 + res : res;
      wires[key] = val = res;
      if (val.runtimeType == int) {
        findDependents(key).map((k) {
          evaluate(k, wires[k]);
        }).toList();
      }
    }
    return val;
  };

  Stopwatch watch = new Stopwatch()..start();
  for (String line in lines) {
    Match m = re.matchAsPrefix(line);
    evaluate(m.group(2), m.group(1));
  }
  watch.stop();

  print("a = ${wires['a']} (${watch.elapsedMilliseconds}ms)");
}

