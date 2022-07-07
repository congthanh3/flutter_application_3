import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:twitter_login/entity/user.dart';

import '../constants/all_constants.dart';
import '../models/chat_user.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  //store login's status
  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.prefs});

  String? getFirebaseUserId() {
    return prefs.getString(FirestoreConstants.id);
  }

  Future<bool> isLoggedIn() async {
    //Flag to move to login page
    bool isLoggedIn = await GoogleSignIn().isSignedIn();
    if (isLoggedIn &&
        prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleGoogleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set(
            {
              FirestoreConstants.displayName: firebaseUser.displayName,
              FirestoreConstants.photoUrl: firebaseUser.photoURL,
              FirestoreConstants.id: firebaseUser.uid,
              "createdAt: ": DateTime.now().millisecondsSinceEpoch.toString(),
              FirestoreConstants.chattingWith: null,
            },
          );

          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.displayName, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          await prefs.setString(
              FirestoreConstants.phoneNumber, currentUser.phoneNumber ?? "");
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(
              FirestoreConstants.displayName, userChat.displayName);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs.setString(
              FirestoreConstants.phoneNumber, userChat.phoneNumber);
          await prefs.setString(
              FirestoreConstants.countryCode, userChat.countryCode);
        }
        // print(firebaseUser);
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  Future<void> googleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }

  Future<bool> handleFacebookSignIn() async {
    // return true;

    _status = Status.authenticating;
    notifyListeners();
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential

    FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    Map<String, dynamic> firebaseUser =
        await FacebookAuth.instance.getUserData();

    final QuerySnapshot result = await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isEqualTo: firebaseUser["id"])
        .get();
    final List<DocumentSnapshot> document = result.docs;
    if (document.isEmpty) {
      firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .doc(firebaseUser["id"])
          .set(
        {
          FirestoreConstants.displayName: firebaseUser["name"],
          FirestoreConstants.photoUrl: firebaseUser["picture"]["data"]["url"],
          FirestoreConstants.id: firebaseUser["id"],
          "createdAt: ": DateTime.now().millisecondsSinceEpoch.toString(),
          FirestoreConstants.chattingWith: null,
        },
      );

      // User? currentUser = firebaseUser;
      await prefs.setString(FirestoreConstants.id, firebaseUser["id"]);
      await prefs.setString(
          FirestoreConstants.displayName, firebaseUser["name"] ?? "");
      await prefs.setString(FirestoreConstants.photoUrl,
          firebaseUser["picture"]["data"]["url"] ?? "");
      await prefs.setString(FirestoreConstants.phoneNumber, "");
    } else {
      DocumentSnapshot documentSnapshot = document[0];
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
      await prefs.setString(FirestoreConstants.id, userChat.id);
      await prefs.setString(
          FirestoreConstants.displayName, userChat.displayName);
      await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
      await prefs.setString(
          FirestoreConstants.phoneNumber, userChat.phoneNumber);
      await prefs.setString(
          FirestoreConstants.countryCode, userChat.countryCode);
    }

    _status = Status.authenticated;
    notifyListeners();
    return true;
  }
}
