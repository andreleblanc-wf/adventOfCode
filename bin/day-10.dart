/**
 * 2 different approaches here.  The compact regex-replace in lookSay()
 * and the more verbose, but faster version lookSay2.
 *
 */

main() {
  RegExp re = new RegExp(r'(\w)\1*');


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


  String runSolution(Function f) {
    String _s = '1113122113';

    for (int i=0; i<50; i++) {
      _s = f(_s);
    }
    return _s;
  }

  int timeSolution(Function sol) {
    Stopwatch watch = new Stopwatch()..start();
    print("Answer: ${runSolution(sol).length}");
    watch.stop();
    return watch.elapsedMilliseconds;
  }

  assert (lookSay(lookSay(lookSay('1211'))) == '13112221');
  assert (lookSay2(lookSay2(lookSay2('1211'))) == '13112221');

  print(timeSolution(lookSay));
  print(timeSolution(lookSay2));
}