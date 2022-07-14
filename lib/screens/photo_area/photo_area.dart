import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/all_constants.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:provider/provider.dart';

import '../../provider/photo_provider.dart';
import '../../widgets/w_custom_arrow_button.dart';

class PhotoArea extends StatefulWidget {
  const PhotoArea({Key? key}) : super(key: key);

  @override
  State<PhotoArea> createState() => _PhotoAreaState();
}

class _PhotoAreaState extends State<PhotoArea> {
  @override
  Widget build(BuildContext context) {
    var photoProvider = Provider.of<PhotoProvider>(context);

    return Container(
        padding: EdgeInsets.all(15),
        child: Stack(
          children: [
            CustomArrowButton(
                alignment: Alignment.centerLeft,
                icon: Icons.arrow_circle_left_outlined,
                onTap: photoProvider.moveDown()),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.25,
                  vertical: MediaQuery.of(context).size.height * 0.25),
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.height * 0.70,
              child: BabylonJSViewer(
                src: AppAssets.wolf,
              ),
            ),
            CustomArrowButton(
                alignment: Alignment.centerRight,
                icon: Icons.arrow_circle_right_outlined,
                onTap: photoProvider.moveUp()),
          ],
        ));
    // Container(
    //   color: AppColors.black,
    //   height: double.infinity,
    //   child: TweenAnimationBuilder<Color?>(
    //       tween: ColorTween(begin: Colors.white, end: Colors.orange),
    //       duration: const Duration(seconds: 4),
    //       builder: (_, Color? color, __) {
    //         return ColorFiltered(
    //           colorFilter: ColorFilter.mode(
    //               color ?? Colors.transparent, BlendMode.modulate),
    //           child: Image.asset(AppAssets.sun),
    //         );
    //       }),
    // );
  }
}
