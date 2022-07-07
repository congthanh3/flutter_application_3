import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/main_provider.dart';
import 'w_bottom_navigation_item_part.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem(
      {Key? key,
      required this.index,
      required this.activeImage,
      required this.notActiveImage,
      required this.notActiveName})
      : super(key: key);

  final int index;
  final String activeImage;
  final String notActiveImage;
  final String notActiveName;

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.333,
      child: GestureDetector(
          onTap: () {
            mainProvider.isSelectIndex = index;
          },
          child: mainProvider.getIndex == index
              ? BottomItemEnable(
                  enableImage: activeImage,
                )
              : BottomItem(image: notActiveImage, name: notActiveName)),
    );
  }
}
