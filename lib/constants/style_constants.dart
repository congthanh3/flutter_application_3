import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'all_constants.dart';

const normalFont = 'Inter-Regular';
const mediumFont = 'Inter-Semi-Bold';
const boldFont = 'Inter-Bold';
const lighFont = 'Inter-Light';

var normalText12 = thinTextStyle(
    color: AppColors.white,
    size: 12,
    fontFamily: normalFont,
    decoration: TextDecoration.none);
var normalTextLink12 = thinTextStyle(
  color: AppColors.white,
  size: 12,
  fontFamily: normalFont,
  decoration: TextDecoration.underline,
  decorationColor: AppColors.white,
);
var normalText12Black = thinTextStyle(
    color: AppColors.white,
    size: 12,
    fontFamily: normalFont,
    decoration: TextDecoration.none);
var normalText16 =
    thinTextStyle(color: AppColors.white, size: 16, fontFamily: normalFont);
var normalTextLink16 = thinTextStyle(
    color: AppColors.white,
    size: 16,
    fontFamily: normalFont,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.white);

var cardTextTitle = mediumTextStyle(
    color: AppColors.white,
    size: 16,
    fontFamily: normalFont,
    decoration: TextDecoration.none);
var cardTextSubTitle = mediumTextStyle(
    color: AppColors.white,
    size: 10,
    fontFamily: normalFont,
    decoration: TextDecoration.none);

var sideBarText = mediumTextStyle(
    color: AppColors.burgundy,
    size: 14,
    fontFamily: normalFont,
    decoration: TextDecoration.none);

var disconnectedStatus = mediumTextStyle(
    color: AppColors.white,
    size: 13,
    fontFamily: normalFont,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.italic);
var connectedStatus = mediumTextStyle(
    color: AppColors.white,
    size: 13,
    fontFamily: normalFont,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.italic);
var unconfigedStatus = mediumTextStyle(
    color: AppColors.white,
    size: 13,
    fontFamily: normalFont,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.italic);

/// Thin text style - w100
TextStyle thinTextStyle({
  required double size,
  required Color color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
}) =>
    TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w100,
        fontFamily: fontFamily ?? normalFont,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor);

TextStyle medium400TextStyle({
  required double size,
  required Color color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
}) =>
    TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily ?? normalFont,
        color: color,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor);

TextStyle mediumTextStyle(
        {required double size,
        required Color color,
        String? fontFamily,
        TextDecoration? decoration,
        Color? decorationColor,
        FontStyle? fontStyle}) =>
    TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily ?? normalFont,
        color: color,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor,
        fontStyle: fontStyle ?? FontStyle.normal);
TextStyle largeTextStyle({
  required double size,
  required Color color,
  String? fontFamily,
  TextDecoration? decoration,
  Color? decorationColor,
}) =>
    TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily ?? normalFont,
        color: color,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: decorationColor);
BoxDecoration containerStyle({
  required Color? color,
  double? bottomLeft,
  double? bottomRight,
  double? topLeft,
  double? topRight,
}) =>
    BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? 0),
          topRight: Radius.circular(topRight ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? 0),
          bottomRight: Radius.circular(bottomRight ?? 0),
        ));

BoxDecoration boxDecoration({
  required Color color,
}) =>
    BoxDecoration(
      color: color,
      border: Border.all(
        color: color,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
