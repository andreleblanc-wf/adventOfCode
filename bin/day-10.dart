main() {
  RegExp re = new RegExp(r'(\w)\1*');
  String s = '1113122113';
  int ITERS = 3;

  String runSolution(Function f) {
    String _s = '1113122113';

    for (int i=0; i<50; i++) {
      _s = f(_s);
    }
    return _s;
  }

  String lookSay(String inp) {
    return re.allMatches(inp).map((m) => "${m
        .group(0)
        .length}${m.group(1)}").join('');
  }

  String lookSay2(String inp) {
    List<String> result = [];
    int count = 0;
    String lastChar = inp[0];
    for (String c in inp.split('')) {
      if (lastChar == c) {
        count ++;
      } else {
        result.add("$count$lastChar");
        count = 1;
        lastChar = c;
      }
    }
    result.add("$count$lastChar");
    return result.join('');
  }

  int timeSolution(Function sol) {

    Stopwatch watch = new Stopwatch()..start();
    runSolution(sol);
    watch.stop();
    return watch.elapsedMilliseconds;
  }

  int averageTime(Function sol) {
    List<int> times = [];
    for (int i=0; i<ITERS; i++) {
      times.add(timeSolution(sol));
    }
    return (times.reduce((a,b) => a+b)/ITERS).floor();
  }

  assert (lookSay(lookSay(lookSay(s))) == lookSay2(lookSay2(lookSay2(s))));
  print(averageTime(lookSay));
  print(averageTime(lookSay2));
  //print("Time: ${watch.elapsedMilliseconds}");
}