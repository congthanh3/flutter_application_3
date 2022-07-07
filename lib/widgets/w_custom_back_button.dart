import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom(
      {Key? key, required this.function, required this.content})
      : super(key: key);
  final Function() function;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        child: content,
        onTap: function,
      ),
      // width: 24,
      height: 24,
    );
  }
}
