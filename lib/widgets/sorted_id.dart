import 'dart:convert';

import 'package:crypto/crypto.dart';

class SortedFunction {
  // static bool isAndroid() {
  //   return false;
  // }

  static String generateChatRoomId(
      {required String user1Email, required String user2Email}) {
    List<String> sortedEmails = [user1Email, user2Email]..sort();
    String concatenatedEmails = sortedEmails.join();
    String hashedId =
        sha256.convert(utf8.encode(concatenatedEmails)).toString();
    return hashedId;
  }
}
