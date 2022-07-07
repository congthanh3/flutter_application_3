import 'package:flutter/material.dart';

import '../constants/all_constants.dart';
import '../generated/l10n.dart';
import '../widgets/w_custom_divider.dart';
import '../widgets/w_icon_close_button.dart';
import '../widgets/w_side_navigation_item.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(top: 44),
      child: Drawer(
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const IconCloseButton(),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SideNavigationBarItem(
                  image: AppAssets.testImage,
                  name: S.of(context).test,
                  function: () {},
                ),
                SideNavigationBarItem(
                  image: AppAssets.testImage,
                  name: S.of(context).test,
                  function: () {},
                ),
                SideNavigationBarItem(
                  image: AppAssets.testImage,
                  name: S.of(context).setting,
                  function: () {
                    Navigator.popAndPushNamed(context, 'settings');
                  },
                ),
              ],
            ),
            Expanded(child: Container()),
            const CustomDivider(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 12),
            ),
            Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, AppColors.greyColor, Colors.white],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
