// 1/10th the speed of python.

import "dart:io";

List<String> lines = new File("./inputs/day-19.txt").readAsLinesSync();

class Repl {
  String search;
  String replace;
  Repl(this.search, this.replace);
}

int part1(List<Repl> replacements, String medicine) {
  Set<String> molecules = new Set<String>();
  for (Repl r in replacements) {
    int idx = 0;
    while (true) {
      idx = medicine.indexOf(r.search, idx+1);
      if (idx == -1) {
        break;
      }
      molecules.add(medicine.replaceFirst(r.search, r.replace, idx));
    }

  }
  return molecules.length;
}

int part2(List<Repl> replacements, String medicine) {
  String mol = medicine;
  int count = 0;
  while (mol != 'e') {
    for (Repl r in replacements) {
      if (mol.contains(r.replace)) {
        mol = mol.replaceFirst(r.replace, r.search);
        count ++;
      }
    }
  }
  return count;
}


main() {
  List<Repl> replacements = [];
  String medicine = null;

  for (String line in lines) {
    List<String> parts = line.trim().split(" => ");
    if (parts.length == 2) {
      replacements.add(new Repl(parts[0], parts[1]));
    } else {
      if (parts[0].trim().length > 0) {
        medicine = parts[0];
      }
    }
  }

  Stopwatch watch = new Stopwatch()..start();
  int moleculeCount = part1(replacements, medicine);
  watch..stop();
  print("Part 1: $moleculeCount in ${watch.elapsedMicroseconds}ms");

  watch..reset()..start();
  int turns = part2(replacements, medicine);
  watch.stop();
  print("Part 2: $turns in ${watch.elapsedMicroseconds}ms");

}


