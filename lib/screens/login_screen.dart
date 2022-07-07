import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/all_constants.dart';
import '../generated/l10n.dart';
import '../provider/auth_provider.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    //show sign in status
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.dimen_30,
              horizontal: Sizes.dimen_20,
            ),
            children: [
              vertical50,
              Text(
                S.of(context).test,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.dimen_26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // vertical30,
              // Row(
              //   children: [
              //     const Text(
              //       'Please login',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontSize: Sizes.dimen_22,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     Container(
              //       height: 40,
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(90),
              //           child: Image.asset('assets/images/login_asking.png')),
              //     ),
              //   ],
              // ),

              vertical30,
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.asset('assets/images/login_logo.png')),
              ),
              vertical50,
              const CustomLoginButton(buttonLabel: "Google Login"),
              const CustomLoginButton2(buttonLabel: "Facebook Login"),
            ],
          ),
          Center(
            child: authProvider.status == Status.authenticating
                ? const CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// class SignInButton extends StatefulWidget {
//   final FaIcon faIcon;
//   final LoginType loginType;
//   final textLabel;

//  const SignInButton(
//       {Key? key,
//       required this.faIcon,
//       required this.loginType,
//       required this.textLabel})
//       : super(key: key);

// }

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    Key? key,
    required this.buttonLabel,
  }) : super(key: key);

  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70),
      child: ElevatedButton(
        onPressed: () async {
          bool isSuccess = await authProvider.handleGoogleSignIn();
          if (isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        child: Text(buttonLabel),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomLoginButton2 extends StatelessWidget {
  const CustomLoginButton2({
    Key? key,
    required this.buttonLabel,
  }) : super(key: key);

  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70),
      child: ElevatedButton(
        onPressed: () async {
          bool isSuccess = await authProvider.handleFacebookSignIn();
          if (isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        child: Text(buttonLabel),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }
}
