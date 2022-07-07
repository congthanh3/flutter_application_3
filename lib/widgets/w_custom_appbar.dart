import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/all_constants.dart';
import '../provider/auth_provider.dart';
import '../screens/login_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return AppBar(
      backgroundColor: AppColors.orangeWeb,
      centerTitle: true,
      title: const Text('Human zone'),
      actions: [
        IconButton(
            onPressed: () async {
              authProvider.googleSignOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.logout)),
        IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ProfilePage()));
            },
            icon: const Icon(Icons.person)),
      ],
    );
  }
}
