import 'package:flutter/material.dart';
import 'theme_color.dart';

class AppTextTheme {
  static TextStyle textLinkStyle = const TextStyle(
    decoration: TextDecoration.underline,
    color: AppColor.primaryColorLight,
    fontSize: 14,
  );

  static TextTheme getDefaultTextTheme() => const TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        titleLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColor.subText,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColor.subText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.subText,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
  static TextTheme getDefaultTextThemeDark() => const TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.subDarkText,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColor.subDarkText,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryDarkText,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryDarkText,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryDarkText,
        ),
      );
}
