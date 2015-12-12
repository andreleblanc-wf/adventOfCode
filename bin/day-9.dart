import "dart:io";


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


void main() {
  Set visited = new Set<String>();
  int totalDistance = 0;
  Map<String, Map<String, int>> distances = new Map<String, Map<String,int>>();

  List<String> lines = new File("../inputs/day-9.txt").readAsLinesSync();
  Stopwatch watch = new Stopwatch()..start();
  lines.forEach((line) {
    var parts = line.split(" = ");
    var parts2 = parts[0].split(" to ");
    var c1 = parts2[0];
    var c2 = parts2[1];
    int dist = int.parse(parts[1]);
    if (!distances.containsKey(c1)) {
      distances[c1] = new Map<String, int>();
    }
    if (!distances.containsKey(c2)) {
      distances[c2] = new Map<String, int>();
    }
    distances[c1][c2] = dist;
    distances[c2][c1] = dist;
  });

  int worst = 0;
  int best = 9999999;

  for (List<String> perm in permutations(distances.keys)) {
    int dist = 0;
    String start = perm[0];
    for (String city in perm.skip(1)) {
      dist += distances[start][city];
      start = city;
    }
    if (dist > worst) {
      worst = dist;
    }
    if (dist < best) {
      best = dist;
    }
  }

  watch.stop();
  print("Best: $best");
  print("Worst: $worst");
  print("Time: ${watch.elapsedMilliseconds}");
}