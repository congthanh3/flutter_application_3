import 'package:flutter/material.dart';

class CustomArrowButton extends StatelessWidget {
  const CustomArrowButton(
      {Key? key,
      required this.alignment,
      required this.icon,
      required this.onTap})
      : super(key: key);
  final AlignmentGeometry alignment;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: Colors.black,
          size: 30.0,
        ),
      ),
    );
  }
}
