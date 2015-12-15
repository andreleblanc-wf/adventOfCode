import 'dart:io';
import 'dart:math';


Iterable<int> reindeerOverTime(Reindeer reindeer, int time) sync* {
  int actionTime = reindeer.duration;
  bool resting = false;
  int distance = 0;
  while (time > 0) {
    time -= 1;
    actionTime -= 1;
    if (!resting) {
      distance += reindeer.speed;
    }
    yield distance;
    if (actionTime == 0) {
      resting = !resting;
      actionTime = resting ? reindeer.rest : reindeer.duration;
    }
  }
}


class Reindeer {
  String name;
  int speed;
  int duration;
  int rest;
  Reindeer(this.name, this.speed, this.duration, this.rest);
}


int part1(List<Reindeer> reindeer) {
  int bestDistance = 0;
  int dist;
  for (Reindeer d in reindeer) {
    dist = reindeerOverTime(d, 2503).last;
    if (dist > bestDistance) {
      bestDistance = dist;
    }
  }
  return bestDistance;
}


Iterable<List> zip(List<Iterable> iterables) sync* {
  List<Iterator> iterators = iterables.map((i) => i.iterator).toList();
  while (iterators[0].moveNext()) {
    iterators.skip(1).map((i) => i.moveNext()).toList();
    yield iterators.map((i) => i.current).toList();
  }
}

int part2(List<Reindeer> reindeer) {
  List<int> scores = new List<int>.filled(reindeer.length, 0);
  List<Iterable<int>> generators = reindeer.map((Reindeer d) => reindeerOverTime(d, 2503)).toList();
  for (List<int> tick in zip(generators)) {
    int bestScore = tick.reduce(max);
    for (int i=0; i<tick.length; i++) {
      if (tick[i] == bestScore) {
        scores[i] ++;
      }
    }
  }
  return scores.reduce(max);
}

main() {
  RegExp parser = new RegExp(r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+)');
  List<Reindeer> reindeer = new List<Reindeer>();
  Match m;
  for (String line in new File("./inputs/day-14.txt").readAsLinesSync()) {
    m = parser.firstMatch(line);
    reindeer.add(new Reindeer(m.group(1), int.parse(m.group(2)), int.parse(m.group(3)), int.parse(m.group(4))));
  }

  Stopwatch watch = new Stopwatch()..start();
  int p1 = part1(reindeer);
  watch.stop();
  print("#1 $p1 in ${watch.elapsedMilliseconds} ms");
  watch..reset()..start();
  int p2 = part2(reindeer);
  watch.stop();
  print("#1 $p2 in ${watch.elapsedMilliseconds} ms");
}

