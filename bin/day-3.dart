import "dart:io";

main(List<String> args) {
  Stopwatch stopwatch = new Stopwatch()..start();

  String data = new File("../inputs/day-3.txt").readAsStringSync();

  Set<int> visited = new Set<int>();

  visited.add(0);

  int cx = 0;
  int cy = 0;
  int rx = 0;
  int ry = 0;

  for (int i=0; i<data.length;i++) {
    if (i % 2 == 0) {
      switch (data[i]) {
        case '^':
          cy--;
          break;
        case 'v':
          cy++;
          break;
        case '<':
          cx--;
          break;
        case '>':
          cx++;
          break;
      }
      visited.add((cy*10000) + cx);
    } else {
        switch (data[i]) {
        case '^':
          ry--;
          break;
        case 'v':
          ry++;
          break;
        case '<':
          rx--;
          break;
        case '>':
          rx++;
          break;
      }
      visited.add((ry*10000) + rx);
    }

  }

  print (visited.length);
  print(stopwatch.elapsedMilliseconds);
}
