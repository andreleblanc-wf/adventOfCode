import "dart:io";
import 'dart:math';


RegExp parser = new RegExp(r'(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)');

int process(List<String> instructions, List<List<int>> grid, Map<String, Function> actionMap) {
  for (String line in instructions) {
    Match match = parser.firstMatch(line);
    String action = match.group(1);
    List<int> points = match.groups([2,3,4,5]).map(int.parse).toList();

    // just in case they try to flip things around
    int minX = min(points[0], points[2]);
    int minY = min(points[1], points[3]);
    int maxX = max(points[0], points[2]);
    int maxY = max(points[1], points[3]);

    for (int x=minX; x<=maxX; x++) {
      for (int y=minY; y<=maxY; y++) {
        grid[y][x] = actionMap[action](grid[y][x]);
      }
    }
  }

  return grid.fold(0, (a,b) => a + b.reduce((c,d) => c + d));
}

List<List<int>> createGrid(int x, int y) {
  List<List<int>> grid = new List<List<int>>();
  // initialize
  for (int i=0; i<y; i++) {
    List<int> row = new List<int>.filled(x, 0);
    grid.add(row);
  }
  return grid;
}

main() {

  List<String> instructions = new File("./inputs/day-6.txt").readAsLinesSync();

  Map<String, Function> part1 = {
    'turn on': (value) => 1,
    'turn off': (value) => 0,
    'toggle': (value) => value == 1 ? 0 : 1
  };

  Map<String, Function> part2 = {
    'turn on': (value) => value + 1,
    'turn off': (value) => max(0, value - 1),
    'toggle': (value) => value + 2
  };


  Stopwatch watch = new Stopwatch();
  watch.start();
  List<List<int>> grid = createGrid(1000,1000);
  print("Part 1: ${process(instructions, grid, part1)}");
  watch.stop();
  print(watch.elapsedMilliseconds);
  watch.reset();
  watch.start();
  grid = createGrid(1000,1000);
  print("Part 2: ${process(instructions, grid, part2)}");
  watch.stop();
  print(watch.elapsedMilliseconds);
}