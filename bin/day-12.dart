import "dart:convert";
import 'dart:io';


int sumDigits(o) {
  if (o is List) {
    return o.map(sumDigits).reduce((a,b) => a + b);
  } else if (o is Map) {
    if (!o.values.contains('red')) {
      return o.values.map(sumDigits).reduce((a,b) => a + b);
    }
  } else if (o is num) {
    return o;
  }
  return 0;
}

main() {
  var data = JSON.decode(new File("./inputs/day-12.txt").readAsStringSync());
  print(sumDigits(data));
}