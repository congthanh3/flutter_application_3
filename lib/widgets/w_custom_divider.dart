import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/all_constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    required this.height,
    this.margin,
    this.padding,
  }) : super(key: key);

  final double height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, AppColors.burgundy, Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      padding: padding,
      margin: margin,
    );
  }
}
