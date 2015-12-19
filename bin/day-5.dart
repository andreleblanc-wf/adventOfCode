import "dart:io";
import "dart:math";
List<String> BLACKLIST = ["ab", "cd", "pq", "xy"];
String VOWELS = "aeiou";

bool isNice(String word) {
  String prev = '';
  String pair;
  bool hasDouble = false;
  int vowels = 0;
  for (int i=0; i<word.length;i++) {
    String char = word[i];
    pair = prev + char;
    if (BLACKLIST.contains(pair)) {
      return false;
    }
    if (VOWELS.contains(char)) {
      vowels += 1;
    }
    if (!hasDouble && pair.length == 2 && pair[0] == pair[1]) {
      hasDouble = true;
    }
    prev = char;
  }
  return hasDouble && vowels >= 3;
}


bool isActuallyNice(String word) {
  String pair;
  String trip;
  bool hasRepeatedPair = false;
  bool hasSeparatedDouble = false;

  for (int i=0; i<word.length; i++) {
    pair = word.substring(i, min(i+2, word.length));
    trip = word.substring(i, min(i+3, word.length));
    if (!hasRepeatedPair && pair.length >= 2) {
      if (word.indexOf(pair, i+2) > -1) {
        hasRepeatedPair = true;
      }
    }
    if (!hasSeparatedDouble && trip.length == 3) {
      if (trip[0] == trip[2]) {
        hasSeparatedDouble = true;
      }
    }
    if (hasSeparatedDouble && hasRepeatedPair) {
      return true;
    }
  }
  return false;
}

main(List<String> args) {
  int niceCount = 0;
  int actuallyNiceCount = 0;

  List<String> words = new File("./inputs/day-5.txt").readAsLinesSync();
  Stopwatch watch = new Stopwatch()..start();
  for (String word in words) {
    if (isNice(word)) {
      niceCount ++;
    }
    if (isActuallyNice(word)) {
      actuallyNiceCount ++;
    }
  }
  print("$niceCount nice words");
  print("$actuallyNiceCount ACTUALLY nice words");
  watch.stop();
  print(watch.elapsedMilliseconds);
}
