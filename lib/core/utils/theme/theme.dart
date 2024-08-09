import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // for light theme
      ),
      brightness: Brightness.light,
      fontFamily: 'Satoshi',
      scaffoldBackgroundColor: AppColors.lightBackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.sp)))));

  static final darkTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      brightness: Brightness.dark,
      fontFamily: 'Satoshi',
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light, // for dark theme
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              overlayColor: Colors.black,
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.sp)))));
}
