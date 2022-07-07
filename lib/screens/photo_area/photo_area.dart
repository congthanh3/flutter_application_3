import 'package:flutter/material.dart';

class PhotoArea extends StatefulWidget {
  const PhotoArea({Key? key}) : super(key: key);

  @override
  State<PhotoArea> createState() => _PhotoAreaState();
}

class _PhotoAreaState extends State<PhotoArea> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        color: Colors.blue,
      ),
    );
  }
}
