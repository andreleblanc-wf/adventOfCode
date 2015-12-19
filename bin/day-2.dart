import "dart:io";
import "dart:math";

main(List<String> args) {
  List<String> lines = new File("./inputs/day-2.txt").readAsLinesSync();
  int totalArea = 0;
  int a = 0;
  int b = 0;
  int c = 0;
  int smallestSide = 0;
  int vol = 0;
  int totalRibbon = 0;
  Stopwatch watch = new Stopwatch()..start();
  for (String line in lines) {

    List<int> dims = line.split("x").map((s) => int.parse(s)).toList();
    dims.sort();

    a = dims[0] * dims[1];
    b = dims[1] * dims[2];
    c = dims[0] * dims[2];

    vol = dims[0] * dims[1] * dims[2];

    totalArea += (2*a) + (2*b) + (2*c);
    totalArea += [a,b,c].reduce(min);

    int smallestPerimeter = dims[0] + dims[0] + dims[1] + dims[1];
    totalRibbon += smallestPerimeter + vol;
  }
  print(totalArea);
  print(totalRibbon);
  watch.stop();
  print(watch.elapsedMilliseconds);
}