import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_assets.dart';

class IconCloseButton extends StatelessWidget {
  const IconCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 12, left: 16),
        child: SvgPicture.asset(AppAssets.iconCancel),
        alignment: Alignment.centerLeft,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
