//PYTHON TIMINGS
//176851 in 149.395942688 ms
//#1 13882464 923 ms
//#2 11171160 269 ms
import 'dart:io';

Iterable<List<int>> sumPermutations(int size, int target) sync* {
  if (size == 1) {
    yield [target];
  } else {
    for (int i=0; i<=target; i++) {
      for (List<int> perm in sumPermutations(size-1, target-i)) {
        yield [i]..addAll(perm);
      }
    }
  }
}




main() {


  final List<Map> ingredients = [];
  final List<String> lines = new File("./inputs/day-15.txt").readAsLinesSync();
  final RegExp parser = new RegExp(r"\w+: \w+ (\-?\d+), \w+ (\-?\d+), \w+ (\-?\d+), \w+ (\-?\d+), \w+ (\-?\d+)");

  for (String line in lines) {
    Match m = parser.firstMatch(line);
    ingredients.add({
      'capacity': int.parse(m.group(1)),
      'durability': int.parse(m.group(2)),
      'flavor': int.parse(m.group(3)),
      'texture': int.parse(m.group(4)),
      'calories': int.parse(m.group(5)),
    });
  }

  final List<String> part1Keys = ['capacity', 'durability', 'flavor', 'texture'];

  int MUL(a,b) => a * b;
  int part1(List<int> perm) {
    Map<String, int> values = {};
    int val;
    for (String attr in part1Keys) {
      val = 0;
      for (int i = 0; i < perm.length; i++) {
        if (perm[i] > 0) {
          val += ingredients[i][attr] * perm[i];
        }
      }
      if (val < 0) {
        val = 0;
      }
      values[attr] = val;
    }
    return values.values.reduce(MUL);
  }

  final List<String> part2Keys = new List<String>.from(part1Keys)..insert(0, 'calories');
  int part2(List<int> perm) {
    Map<String, int> values = {};
    int val;
    for (String attr in part1Keys) {
      val = 0;
      int count;
      for (int i = 0; i < perm.length; i++) {
        count = perm[i];
        if (count > 0) {
          val += ingredients[i][attr] * count;
        }
      }

      if (attr == 'calories' && val != 500) {
        return -1;
      }

      if (val < 0) {
        val = 0;
      }
      values[attr] = val;
    }
    return values.values.reduce(MUL);
  }
  Stopwatch watch = new Stopwatch()..start();
  final List<List<int>> perms = sumPermutations(4, 100).toList();
  watch.stop();
  print("Generated permutations in ${watch.elapsedMilliseconds}ms");
  int bestScore = 0;
  int score = 0;
  watch..reset()..start();
  for (List<int> perm in perms) {
    score = part1(perm);
    if (score > bestScore) {
      bestScore = score;
    }
  }
  watch.stop();
  print("#1 $bestScore took ${watch.elapsedMilliseconds}ms");

  bestScore = 0;
  score = 0;
  watch..reset()..start();
  for (List<int> perm in perms) {
    score = part2(perm);
    if (score > bestScore) {
      bestScore = score;
    }
  }
  watch.stop();
  print("#2 $bestScore took ${watch.elapsedMilliseconds}ms");

}

