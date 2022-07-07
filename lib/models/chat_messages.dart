import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/all_constants.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot docs) {
    String idFrom = docs.get(FirestoreConstants.idFrom);
    String idTo = docs.get(FirestoreConstants.idTo);
    String timestamp = docs.get(FirestoreConstants.timestamp);
    String content = docs.get(FirestoreConstants.content);
    int type = docs.get(FirestoreConstants.type);

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
