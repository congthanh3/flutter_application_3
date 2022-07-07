import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../utilities/parse_utils.dart';

class LocalPushNotificationHelper {
  static final LocalPushNotificationHelper _singleton =
      LocalPushNotificationHelper();

  static LocalPushNotificationHelper get instance => _singleton;

  static const defaultIcon = "@mipmap/ic_launcher";
  static const _channelId = "thanh.test";
  static const _channelName = "Hot hot";
  static const _channelDescription = "Update hot news every day";
  static const _bitCount = 31;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //support action select notification
  static final BehaviorSubject<String?> _selectNotificationSubject =
      BehaviorSubject<String?>();

  BehaviorSubject<String?> get selectNotificationSubject =>
      _selectNotificationSubject;

  int get _randomNotificationId =>
      Random().nextInt(pow(2, _bitCount).toInt() - 1);

  Future<NotificationAppLaunchDetails?> get details =>
      _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  Future<void> init() async {
    // from android/app/src/main/res/drawable/app_icon.png
    const androidInit = AndroidInitializationSettings(defaultIcon);
    const iOSInit = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const init = InitializationSettings(android: androidInit, iOS: iOSInit);

    //event when select notification
    await _flutterLocalNotificationsPlugin.initialize(
      init,
      onSelectNotification: (value) => _selectNotificationSubject.add(value),
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDescription,
            importance: Importance.high,
          ),
        );
  }

  Future<void> notify(RemoteMessage? notification) async {
    // File? imageFile;
    // if (notification.image.isNotEmpty) {
    //   imageFile = await FileUtils.getImageFileFromUrl(notification.image);
    // }

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      autoCancel: true,
      enableVibration: true,
      playSound: true,
      // styleInformation: imageFile != null
      //     ? BigPictureStyleInformation(
      //         FilePathAndroidBitmap(imageFile.path),
      //         hideExpandedLargeIcon: true,
      //       )
      //     : null,
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (notification?.notification?.android != null) {
      await _flutterLocalNotificationsPlugin
          .show(
            _randomNotificationId,
            notification?.notification?.title,
            notification?.notification?.body,
            platformChannelSpecifics,
            payload: jsonEncode(notification?.data),
          )
          .onError((error, stackTrace) =>
              // ignore: avoid_print
              print('Can not show notification cause $error'));
    }
  }

  Future<void> handleSelectNotificationMap(
    Map<String, dynamic>? data,
  ) async {
    switch (data?["notification_type"]) {
      case "chat":
        break;
      default:
        return;
    }
  }

  Future<void> handleSelectNotificationPayload(
    String? payload,
  ) async {
    final data = ParseUtils.parseStringToMap(payload);
    if (data != null) {
      handleSelectNotificationMap(data);
    }
  }
}
