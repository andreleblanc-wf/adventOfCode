import "dart:io";

main(List<String> args) {

  String data = new File("../inputs/day-1.txt").readAsStringSync();
  int floor = 0;

  for (int i=0; i<data.length;i++) {

    switch(data[i]) {
      case '(': floor++; break;
      case ')': floor--; break;
    }

    if (floor < 0) {
      print (i+1);
      break;
    }
  }

  print (floor);

}
