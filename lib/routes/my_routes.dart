import 'package:flutter/material.dart';

// import '../screens/chat_screen.dart';
import '../screens/home_screen.dart';
import '../screens/setting_area/setting_language.dart';
import '../screens/splash_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case 'homeScreen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'settings':
        return MaterialPageRoute(builder: (_) => const SettingLanguageScreen());
      //TODO: How to active case chatScreen since need to have parameter ?
      // case 'chatScreen':
      //   return MaterialPageRoute(builder: (_) => const ChatScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}.'),
            ),
          ),
        );
    }
  }
}
