import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, this.underLineLength, {super.key});
  final String title;
  final double underLineLength;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(title),
            _underLineEffect(underLineLength),
          ],
        ),
      ),
    );
  }
}

Text _title(String title) {
  return Text(
    title,
    style: AppFontStyles.medium19,
  );
}

Container _underLineEffect(double underLineLength) {
  return Container(
    height: 5.h,
    width: underLineLength.w,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.secondary,
          Get.isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(3.sp),
          topLeft: Radius.circular(3.sp),
        ),
        color: AppColors.secondary),
  );
}
