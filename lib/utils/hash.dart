import 'dart:convert';
import 'package:crypto/crypto.dart';

String generateMD5fromStringList(List<String> strings) {
  return md5.convert(utf8.encode(strings.join("_"))).toString();
}
