import 'dart:io';

RegExp parser = new RegExp(r'(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)');

Iterable<List> permutations(Iterable src) sync* {
  if (src.length == 1) {
    yield src;
  } else {
    for (var item in src) {
      for (List p in permutations(src.where((i) => i != item).toList())) {
        yield p..add(item);
      }
    }
  }
}

main() {
  Map<String, Map<String, int>> prefs = {};
  Match m;
  int val;
  for (String line in new File("./inputs/day-13.txt").readAsLinesSync()) {
    m = parser.firstMatch(line);
    if (!prefs.containsKey(m.group(1))) {
      prefs[m.group(1)] = {};
    }
    val = int.parse(m.group(3));
    if (m.group(2) == 'lose') {
      val *= -1;
    }
    prefs[m.group(1)][m.group(4)] = val;
  }
  // Part 2
  prefs['Andre'] = {};
  for (String k in prefs.keys) {
    prefs['Andre'][k] = 0;
    prefs[k]['Andre'] = 0;
  }

  int best = -9999999;
  int permLen = prefs.keys.length;
  Stopwatch watch = new Stopwatch()
    ..start();
  for (List<String> perm in permutations(prefs.keys)) {
    int sum = 0;
    for (int i = 0; i < permLen; i++) {
      sum += prefs[perm[i]][perm[i == 0 ? permLen - 1 : i - 1]];
      sum += prefs[perm[i]][perm[i == permLen - 1 ? 0 : i + 1]];
    }
    if (sum > best) {
      best = sum;
    }
  }
  watch.stop();
  print("$best took ${watch.elapsedMilliseconds}ms");
}