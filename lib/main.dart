import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/provider/main_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'helper/firebase_messaging_helper.dart';
import 'helper/local_push_notification_help.dart';
import 'provider/auth_provider.dart';
import 'provider/chat_provider.dart';
import 'provider/home_provider.dart';
import 'provider/movie_provider.dart';
import 'provider/photo_provider.dart';
import 'routes/my_routes.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingHelper.instance.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  //turn MyApp into statefull becase need to initState
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  final SharedPreferences prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // FirebaseMessagingHelper
    FirebaseMessagingHelper.instance.onMessage.listen((value) => {
          LocalPushNotificationHelper.instance.notify(value),
          print("[FirebaseMessagingHelper] :deviceToken $value ")
        });
    FirebaseMessagingHelper.instance.onMessageOpenedApp.listen((event) {
      LocalPushNotificationHelper.instance
          .handleSelectNotificationMap(event.data);
    });
    FirebaseMessagingHelper.instance.getInitialMessage.then((value) {
      if (value != null) {
        LocalPushNotificationHelper.instance
            .handleSelectNotificationMap(value.data);
      }
    });
    // LocalPushNotificationHelper
    // LocalPushNotificationHelper.instance.selectNotificationSubject.listen(
    //   LocalPushNotificationHelper.instance.handleSelectNotificationPayload,
    // );
    // LocalPushNotificationHelper.instance.details.then((value) {
    //   if (value != null) {
    //     LocalPushNotificationHelper.instance
    //         .handleSelectNotificationPayload(value.payload);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => MovieStore()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseFirestore: firebaseFirestore,
            prefs: widget.prefs,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        Provider<ProfileProvider>(
          create: (_) => ProfileProvider(
            prefs: widget.prefs,
            firebaseFirestore: firebaseFirestore,
            firebaseStorage: firebaseStorage,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: widget.prefs,
            firebaseStorage: firebaseStorage,
            firebaseFirestore: firebaseFirestore,
          ),
        )
      ],
      child: Consumer<MainProvider>(
        builder: (context, provider, snapshot) {
          return MaterialApp(
            locale: Provider.of<MainProvider>(context).getCurrentLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: "App Chat",
            home: const SplashScreen(),
            onGenerateRoute: MyRouter.generateRoute,
          );
        },
      ),
    );
  }
}
