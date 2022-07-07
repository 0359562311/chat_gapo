import 'package:chat_intern/theme/color_theme.dart';
import 'package:flutter/material.dart';

abstract class AppTextTheme {
  static TextStyle get headingMedium => TextStyle(
      fontWeight: FontWeight.w600,
      color: AppColors.contentPrimary,
      fontSize: 16,
      height: 24 / 16);
  static TextStyle get headingMediumBold =>
      headingMedium.copyWith(fontWeight: FontWeight.w700);

  static TextStyle get bodyLarge => TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.contentPrimary,
      fontSize: 16,
      height: 24 / 16);
  static TextStyle get bodyLargeBold =>
      bodyLarge.copyWith(fontWeight: FontWeight.w700);

  static TextStyle get bodyMedium => TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.contentPrimary,
      fontSize: 14,
      height: 20 / 14);
  static TextStyle get bodyMediumBold =>
      bodyMedium.copyWith(fontWeight: FontWeight.w700);

  static TextStyle get bodySmall => TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.contentPrimary,
      fontSize: 12,
      height: 16 / 12);
  static TextStyle get bodySmallBold =>
      bodySmall.copyWith(fontWeight: FontWeight.w700);
}
