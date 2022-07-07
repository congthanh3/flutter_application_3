import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../constants/all_constants.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(children: [
        SvgPicture.asset(
          image,
          height: 24,
          width: 24,
        ),
        const SizedBox(
          height: 6,
        ),
        Center(child: Text(name)),
      ]),
    );
  }
}

class BottomItemEnable extends StatelessWidget {
  const BottomItemEnable({
    Key? key,
    required this.enableImage,
  }) : super(key: key);

  final String enableImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          SvgPicture.asset(
            enableImage,
            height: 24,
            width: 24,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(child: SvgPicture.asset(AppAssets.iconActive)),
        ],
      ),
    );
  }
}
