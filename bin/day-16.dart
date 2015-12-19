import 'dart:io';

RegExp parser = new RegExp(r'Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)');
List<String> lines = new File('./inputs/day-16.txt').readAsLinesSync();


bool part1(Map<String, int> needle, Map<String, int> sue) {
  for (String attrib in sue.keys) {
    if (needle[attrib] != sue[attrib]) {
      return false;
    }
  }
  return true;
}


bool part2(Map<String, int> needle, Map<String, int> sue) {
  for (String attrib in sue.keys) {
    if (attrib == 'cats' || attrib == 'trees') {
      if (needle[attrib] >= sue[attrib]) {
        return false;
      }
    } else if (attrib == 'pomeranians' || attrib == 'goldfish') {
      if (needle[attrib] <= sue[attrib]) {
        return false;
      }
    } else if (needle[attrib] != sue[attrib]) {
      return false;
    }
  }
  return true;
}


main() {
  Map<String, Map<String, int>> allSues = {};
  for (String line in lines) {
    Match m = parser.firstMatch(line);
    allSues[m.group(1)] = {
      m.group(2): int.parse(m.group(3)),
      m.group(4): int.parse(m.group(5)),
      m.group(6): int.parse(m.group(7)),
    };
  }

  Map<String, int> needle = {
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
  };

  Stopwatch watch = new Stopwatch()..start();
  String match;
  for (String sueId in allSues.keys) {
    if (part1(needle, allSues[sueId])) {
      match = sueId;
      break;
    }
  }
  watch.stop();
  print("#1 ${match} in ${watch.elapsedMicroseconds} microseconds");
  watch..reset()..start();
  match = null;
  for (String sueId in allSues.keys) {
    if (part2(needle, allSues[sueId])) {
      match = sueId;
      break;
    }
  }
  watch.stop();
  print("#2 ${match} in ${watch.elapsedMicroseconds} microseconds");
}