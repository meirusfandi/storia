import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storia/core/utils/color_widget.dart';

class TextWidget {
  static Text manropeBold(String title,
      {TextAlign? textAlign,
      Color? color,
      double? size,
      int? maxLine,
      TextOverflow? overflow}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine,
      overflow: overflow,
      style: textManropeSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w700,
          color: color ?? ColorWidget.textPrimaryColor),
    );
  }

  static Text manropeSemiBold(String title,
      {TextAlign? textAlign,
      Color? color,
      double? size,
      int? maxLine,
      TextOverflow? overflow}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine,
      overflow: overflow,
      style: textManropeSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w600,
          color: color ?? ColorWidget.textPrimaryColor),
    );
  }

  static Text manropeLight(String title,
      {TextAlign? textAlign,
      Color? color,
      double? size,
      int? maxLine,
      TextOverflow? overflow}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine,
      overflow: overflow,
      style: textManropeSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w500,
          color: color ?? ColorWidget.textPrimaryColor),
    );
  }

  static Text manropeRegular(String title,
      {TextAlign? textAlign,
      Color? color,
      double? size,
      int? maxLine,
      TextOverflow? overflow}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine,
      overflow: overflow,
      style: textManropeSetting(
          size: size ?? 12.0,
          fontWeight: FontWeight.w400,
          color: color ?? ColorWidget.textPrimaryColor),
    );
  }

  static TextStyle textManropeSetting(
      {double? size,
      FontWeight? fontWeight,
      Color? color,
      FontStyle? fontStyle,
      TextDecoration? decoration}) {
    return GoogleFonts.manrope(
        fontSize: size ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorWidget.textPrimaryColor,
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: decoration);
  }
}
