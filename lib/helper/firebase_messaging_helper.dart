import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseMessagingHelper {
  final _messaging = FirebaseMessaging.instance;

  static final FirebaseMessagingHelper _singleton = FirebaseMessagingHelper();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  //init 1 time when app start
  static FirebaseMessagingHelper get instance => _singleton;
  //Stream to get token
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
  //receive message when USING app
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;
  //click message and have message infor
  Future<RemoteMessage?> get getInitialMessage =>
      _messaging.getInitialMessage();
  //get token
  Future<String?> get deviceToken => _messaging.getToken();

  //receive message when CLOSE app
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final connectivityResult = await Connectivity().checkConnectivity();
    //check internet function
    if ([
      ConnectivityResult.mobile,
      ConnectivityResult.wifi
    ] //same with connectivityResult==ConnectivityResult.mobile ||connectivityResult==ConnectivityResult.wifi
        .contains(connectivityResult)) {
      deviceToken.then((value) {
        // ignore: avoid_print
        print("[FirebaseMessagingHelper] :deviceToken $value ");
      }).catchError((err) {
        // ignore: avoid_print
        print("[FirebaseMessagingHelper] :err $err ");
      });
    }
    await requestPermission();
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final NotificationSettings settings =
          await _messaging.requestPermission();
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
        case AuthorizationStatus.provisional:
          return true;
        default:
          return false;
      }
    }
    return true;
  }
}

Future _handleBackgroundMessage(RemoteMessage remoteMessage) async {
  // handle background
}
