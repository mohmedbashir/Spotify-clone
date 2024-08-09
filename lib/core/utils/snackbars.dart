import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackbarController pushSnackBar({
  required String title,
  required String info,
  SnackbarType? status,
}) {
  return Get.snackbar(title, info,
      icon: Icon(
        status == SnackbarType.fail
            ? Icons.error_outline_rounded
            : Icons.done_outlined,
        color: status == SnackbarType.fail ? Colors.red : AppColors.primary,
        size: 30.sp,
      ),
      duration: const Duration(seconds: 6),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Get.isDarkMode ? Colors.black : Colors.white,
      backgroundColor: Get.isDarkMode
          ? Colors.white.withOpacity(.4)
          : Colors.black.withOpacity(.4));
}

enum SnackbarType { sucsess, fail }
