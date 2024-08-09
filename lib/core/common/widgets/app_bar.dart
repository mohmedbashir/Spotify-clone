import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/utils/assets/vectors.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.onBackPressed, this.leadingIcon, this.title});

  final VoidCallback onBackPressed;
  final IconData? leadingIcon;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 15.h),
        child: CircleAvatar(
          radius: 10.sp,
          backgroundColor: Colors.grey.withOpacity(.2),
          child: InkWell(
            borderRadius: BorderRadius.circular(50.sp),
            onTap: onBackPressed,
            child: Container(
              padding: EdgeInsets.all(8.sp),
              child: Icon(
                leadingIcon ?? CupertinoIcons.back,
                weight: .2,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: title != null
          ? Text(title!, style: AppFontStyles.bold18)
          : SvgPicture.asset(
              AppVectors.logo,
              height: 30.h,
            ),
    );
  }
}
