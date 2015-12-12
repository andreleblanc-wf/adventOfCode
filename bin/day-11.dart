// This is a direct port of the python version.
// the main difference is the use of String.fromCharCode and String.codeUnits
// which seems like a necessary evil of string manipulation in dart.
RegExp pairsPattern = new RegExp(r'(\w+)\1.*(\w)\2');

List<String> triplets = 'abcdefghijklmnopqrstuvwx'.split('').map(
    (String c) => (c + new String.fromCharCode(c.codeUnits[0]+1)
                   + new String.fromCharCode(c.codeUnits[0]+2))).toList();

String increment(String input) {
  int last = input.codeUnits.last;
  if (last == 122) {
    return increment(input.substring(0, input.length-1)) + 'a';
  } else {
    return input.substring(0, input.length-1) + new String.fromCharCode(last+1);
  }
}

bool isValid(String pw) {
  if (pw.contains('l') || pw.contains('i') || pw.contains('o')) {
    return false;
  }
  if (!pairsPattern.hasMatch(pw)) {
    return false;
  }
  bool found = false;
  for (String trip in triplets) {
    if (pw.contains(trip)) {
      found = true;
      break;
    }
  }
  return found;
}

main() {
  Stopwatch watch = new Stopwatch()..start();
  String password = 'hepxcrrq';
  while (!isValid(password)) {
    password = increment(password);
  }
  watch.stop();
  print("Next Password is $password (took ${watch.elapsedMilliseconds} ms)");
  watch..reset()..start();
  password = increment(password);
  while(!isValid(password)) {
    password = increment(password);
  }
  watch.stop();
  print("Next Password is $password (took ${watch.elapsedMilliseconds} ms)");
}