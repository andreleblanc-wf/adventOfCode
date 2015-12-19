/**
 * This is a mostly direct port of the python version. its still about 5x slower
 * and I'm not entirely sure why.
 */

import 'dart:io';

Map<String, Function> ops = {
  'NOT': (int v) => ~v,
  'AND': (int a, int b) => a & b,
  'OR': (int a, int b) => a | b,
  'RSHIFT': (int a, int b) => a >> b,
  'LSHIFT': (int a, int b) => a << b
};


main() {
  Map<String, dynamic> wires = {};
  List<String> lines = new File("./inputs/day-7.txt").readAsLinesSync();
  Stopwatch watch = new Stopwatch();


  for (String line in lines) {
    List<String> parts = line.split(" -> ");
    wires[parts[1]] = parts[0];
  }
  watch.start();
  int evaluate(key) {
    if (key is num) {
      return key;
    } else if (int.parse(key, onError: (e) => null) != null) {
      return int.parse(key);
    } else {
      var val = wires[key];
      if (val is num) {
        return val;
      } else if (int.parse(val, onError: (e) => null) != null) {
        wires[key] = int.parse(val);
      } else if (wires.containsKey(val)) {
        wires[key] = evaluate(val);
      } else {
        List<String> parts = val.split(' ');
        if (parts.length == 3) {
          // binary
          wires[key] = ops[parts[1]](evaluate(parts[0]), evaluate(parts[2]));
        } else if (parts.length == 2) {
          wires[key] = ops[parts[0]](evaluate(parts[1]));
        }
      }
      return wires[key];
    }
  }

  int answer = evaluate('a');
  watch.stop();
  print("a = $answer (${watch.elapsedMilliseconds}ms)");

}
