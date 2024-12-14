import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/core/fonts/font_manager.dart';

class TextStylesApp {
  ///weight: 300
  static TextStyle light({
    double fontSize = 14.0,
    required Color color,
    double? lineHeight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightApp.light,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 400
  static TextStyle regular({
    double fontSize = 16.0,
    required Color color,
    double? lineHeight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 500
  static TextStyle medium({
    double fontSize = 16.0,
    required Color color,
    double? lineHeight,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeightApp.medium,
        color: color,
        height: lineHeight != null ? lineHeight / fontSize : null,
        fontStyle: fontStyle);
  }

  ///weight: 600
  static TextStyle semiBold({
    double fontSize = 18.0,
    required Color color,
    double? lineHeight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightApp.semibold,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  ///weight: 700
  static TextStyle bold({
    double fontSize = 18.0,
    required Color color,
    double? lineHeight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  static TextStyle heading1({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: 52 / 40,
      letterSpacing: -1.2,
    );
  }

  static TextStyle heading2({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: 42 / 32,
      letterSpacing: -1.0,
    );
  }

  static TextStyle heading3({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: 36 / 28,
      letterSpacing: -0.8,
    );
  }

  static TextStyle heading4({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: 32 / 24,
      letterSpacing: -0.6,
    );
  }

  static TextStyle heading5({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: 28 / 20,
      letterSpacing: -0.2,
    );
  }

  static TextStyle heading6({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeightApp.bold,
      color: color,
      height: 26 / 16,
      letterSpacing: 0,
    );
  }

  static TextStyle subtitle1({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeightApp.semibold,
      color: color,
      height: 32 / 22,
      letterSpacing: -0.6,
    );
  }

  static TextStyle subtitle2({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeightApp.semibold,
      color: color,
      height: 28 / 18,
      letterSpacing: -0.2,
    );
  }

  static TextStyle subtitle3({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeightApp.semibold,
      color: color,
      height: 26 / 16,
      letterSpacing: 0,
    );
  }

  static TextStyle subtitle4({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeightApp.semibold,
      color: color,
      height: 24 / 14,
      letterSpacing: 0,
    );
  }

  static TextStyle subtitle5({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeightApp.semibold,
      color: color,
      height: 18 / 12,
      letterSpacing: 0,
    );
  }

  static TextStyle paragraph1({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 28 / 18,
      letterSpacing: -0.2,
    );
  }

  static TextStyle paragraph2({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 26 / 16,
      letterSpacing: 0,
    );
  }

  static TextStyle paragraph3({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 24 / 14,
      letterSpacing: 0,
    );
  }

  static TextStyle caption1({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 18 / 12,
      letterSpacing: 0,
    );
  }

  static TextStyle caption2({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 16 / 10,
      letterSpacing: 0,
    );
  }

  static TextStyle overline({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 8.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 12 / 8,
      letterSpacing: 0,
    );
  }

  static TextStyle description({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 18 / 12,
      letterSpacing: 0,
    );
  }

  static TextStyle description2({
    required Color color,
  }) {
    return TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeightApp.regular,
      color: color,
      height: 16 / 10,
      letterSpacing: 0,
    );
  }
}
