/**
 * Could not be bothered to implement 'combinations' myself after being spoiled
 * by python.  there's a 3rd party lib 'trotter' that does it.
 * instead of pulling it in, I just copied the relevant bits
 * see: https://bitbucket.org/ram6ler/dart_trotter/wiki/Home
 *
 * Performance here is attrocious compared to python,
 * even after some cheating by only testing combinations of
 * length 4-(containers.length-3) which had almost zero impact.
 *
 */

Map<int, int> _factCache = {};

int _adjustedIndex(int k, int n) {
  while (k < 0) k += n;
  k %= n;
  return k;
}

int _fact(int n) =>
    _factCache.containsKey(n) ? _factCache[n] :
    (n < 2 ? 1 : _factCache[n] = n * _fact(n - 1));

int _nPr(int n, int r) => _fact(n) ~/ _fact(n - r);

int _nCr(int n, int r) => _nPr(n, r) ~/ _fact(r);

List _combination(int k, int r, List elements) {
  int
  n = elements.length,
      position = 0,
      d = _nCr(n - position - 1, r - 1)
  ;

  while (k >= d) {
    k -= d;
    ++position;
    d = _nCr(n - position - 1, r - 1);
  }

  if (r == 0) return [];
  else {
    List tail = elements.sublist(position + 1);
    return [elements[position]]
      ..addAll(_combination(k, r - 1, tail));
  }
}

abstract class _Combinatorics {
  List _elements;
  int _length;

  /// The list from which the objects are selected
  List get elements => new List.from(_elements, growable: false);

  /// The number of arrangements "contained" in this pseudo-list.
  int get length => _length;

  /// The kth arrangement. 
  List operator [](int k);

  /**
   * Returns a range of arrangements.
   *
   * The arrangements "stored" in this pseudo-list from index `[from]`
   * up to but not including `[to]`.
   *
   */
  List range([int from = 0, int to = -1]) {
    if (to == -1) to = length;
    return new List.generate(to - from, (int i) => this[from + i]);
  }

}

class Combinations extends _Combinatorics {
  int _r;

  /// The number of items taken from [elements].
  int get r => _r;


  Combinations(int r, List elements) {
    assert(r >= 0 && r <= elements.length);
    _elements = new List.from(elements);
    _r = r;
    _length = _nCr(elements.length, r);
  }

  @override List operator [](int k) => _combination(
      _adjustedIndex(k, length),
      r,
      elements
  );

  @override String toString() =>
      "Pseudo-list containing all $length $r-combinations of items from $elements.";
}

main() {
  // part 1
  Stopwatch watch = new Stopwatch()..start();
  List<int> containers = [43, 3, 4, 10, 21, 44, 4, 6, 47, 41,
                          34, 17, 17, 44, 36, 31, 46, 9, 27, 38];
  int combos = 0;
  for (int i=4; i<containers.length-3; i++) {
    Combinations combinations = new Combinations(i, containers);
    for (int ci=0; ci<combinations.length; ci++) {
      if (combinations[ci].reduce((a,b) => a+b) == 150) {
        combos ++;
      }
    }
  }
  print(combos);
  watch.stop();
  print("Part 1: $combos in ${watch.elapsedMilliseconds}ms");
  watch..reset()..start();

  combos = 0;
  for (int i=4; i<containers.length-3; i++) {
    Combinations combinations = new Combinations(i, containers);
    for (int ci=0; ci<combinations.length; ci++) {
      if (combinations[ci].reduce((a,b) => a+b) == 150) {
        combos ++;
      }
    }
    if (combos > 0) {
      break;
    }
  }
  print(combos);
  watch.stop();
  print("Part 2: $combos in ${watch.elapsedMilliseconds}ms");
}