import "dart:io";
import "package:crypto/crypto.dart";


main(List<String> args) {
  MD5 md5;
  String text;
  String privKey = "yzbqklnj";
  String digest = "";
  int counter = 0;
  Stopwatch watch = new Stopwatch()..start();
  while (!digest.startsWith("000000")) {
    counter ++;
    text = privKey + counter.toString();
    md5 = new MD5();
    md5.add(text.codeUnits);
    List<int> bytes = md5.close();
    digest = CryptoUtils.bytesToHex(bytes);
  }
  print(counter);
  watch.stop();
  print(watch.elapsedMilliseconds);
}
