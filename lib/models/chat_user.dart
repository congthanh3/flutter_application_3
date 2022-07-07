import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../constants/all_constants.dart';

class ChatUser extends Equatable {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String countryCode;
  final String aboutMe;

  const ChatUser(
      {required this.id,
      required this.photoUrl,
      required this.displayName,
      required this.phoneNumber,
      required this.countryCode,
      required this.aboutMe});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? countryCode,
    String? email,
  }) =>
      ChatUser(
          id: id ?? this.id,
          photoUrl: photoUrl ?? this.photoUrl,
          displayName: nickname ?? displayName,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          countryCode: countryCode ?? this.countryCode,
          aboutMe: email ?? aboutMe);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.displayName: displayName,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.phoneNumber: phoneNumber,
        FirestoreConstants.countryCode: countryCode,
        FirestoreConstants.aboutMe: aboutMe,
      };

  factory ChatUser.fromDocument(DocumentSnapshot docs) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String countryCode = "";
    String aboutMe = "";

    try {
      photoUrl = docs.get(FirestoreConstants.photoUrl);
      nickname = docs.get(FirestoreConstants.displayName);
      countryCode = docs.get(FirestoreConstants.countryCode);
      phoneNumber = docs.get(FirestoreConstants.phoneNumber);
      aboutMe = docs.get(FirestoreConstants.aboutMe);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
        id: docs.id,
        photoUrl: photoUrl,
        displayName: nickname,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        aboutMe: aboutMe);
  }
  @override
  List<Object?> get props =>
      [id, photoUrl, displayName, phoneNumber, countryCode, aboutMe];
}
