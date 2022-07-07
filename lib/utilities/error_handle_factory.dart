import 'package:flutter/material.dart';

import '../repository/remote/error/app_exception.dart';
// import 'package:logger/logger.dart';
// import 'package:sample/repository/remote/error/app_exception.dart';

// var logger = Logger();

class ErrorHandleFactory {
  ErrorHandleFactory._();

  static void handleErrorByType(
    BuildContext context,
    Object error,
  ) {
    switch (error) {
      case RemoteException:
        break;
      case NotInternet:
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(error.toString()),
                    Text('$error'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      default:
        // logger.e(error.toString());
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Something Error!'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
    }
  }
}
