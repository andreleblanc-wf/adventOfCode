import "dart:io";

void main() {
  List<String> lines = new File("./inputs/day-8.txt").readAsLinesSync();

  RegExp eval = new RegExp(r'\\(x[0-9a-f][0-9a-f]|.)');
  RegExp escape = new RegExp(r'("|\\)');

  Stopwatch watch = new Stopwatch()..start();
  print(lines.fold(0, (p, l) => p + (l.length - l.substring(1, l.length-1).replaceAll(eval, '_').length)));
  print(lines.fold(0, (p, l) => p + (2 + l.replaceAllMapped(escape, (m) => r'\' + m.group(1)).length - l.length)));
  watch.stop();
  print(watch.elapsedMilliseconds);
}