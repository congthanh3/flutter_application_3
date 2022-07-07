import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/all_constants.dart';

class SideNavigationBarItem extends StatelessWidget {
  const SideNavigationBarItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.function})
      : super(key: key);
  final String image;
  final String name;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.greyColor,
              // color: Palette.scienceBlue,
            ),
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              image,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: sideBarText,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ]),
      ),
    );
  }
}
