import 'dart:io';

Set<int> readState(String fname) {
  int i = 0;
  Set<int> results = new Set<int>();
  for (String line in new File(fname).readAsLinesSync()) {
    for (String char in line.split('')) {

      if (char == '#') {
        results.add(i);
      }
      i ++;
    }
  }
  return results;
}

Set<int> evolve(Set<int> state, Set<int> initialState) {
  Set<int> newState = new Set<int>.from(initialState);
  int x, y, litNeighbours;
  for (int i=0; i<10000; i++) {
    y = i ~/ 100;
    x = i % 100;
    litNeighbours = 0;
    if (x != 0) {
      if (y != 0 && state.contains(i-101))
        litNeighbours += 1;
      if (y != 99 && state.contains(i+99))
        litNeighbours += 1;
      if (state.contains(i-1))
        litNeighbours += 1;
    }
    if (x != 99) {
      if (y != 0 && state.contains(i-99))
        litNeighbours += 1;
      if (y != 99 && state.contains(i+101))
        litNeighbours += 1;
      if (state.contains(i+1))
        litNeighbours += 1;
    }

    if (y != 0 && state.contains(i-100))
      litNeighbours += 1;
    if (y != 99 && state.contains(i+100))
      litNeighbours += 1;

    if (state.contains(i)) {
      if (litNeighbours == 2 || litNeighbours == 3) {
        newState.add(i);
      }
    } else {
      if (litNeighbours == 3) {
        newState.add(i);
      }
    }
  }
  return newState;
}

main() {
  Stopwatch watch = new Stopwatch()..start();
  Set<int> stuckLights = new Set<int>();
  Set<int> initialLights = readState('./inputs/day-18.txt');
  Set<int> state = initialLights.union(stuckLights);
  for (int i=0; i<100; i++) {
    state = evolve(state, stuckLights);
  }
  watch.stop();
  print("Part 1: ${state.length} in ${watch.elapsedMilliseconds}ms");;
  watch..reset()..start();
  stuckLights = new Set<int>.from([0, 99, 9999, 9900]);
  initialLights = readState('./inputs/day-18.txt');
  state = initialLights.union(stuckLights);
  for (int i=0; i<100; i++) {
    state = evolve(state, stuckLights);
  }
  watch.stop();
  print("Part 2: ${state.length} in ${watch.elapsedMilliseconds}ms");;

}