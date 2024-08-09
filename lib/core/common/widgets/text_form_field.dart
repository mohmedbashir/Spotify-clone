import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.validator,
      this.isObsecure});

  final String hintText;
  final Widget? suffixIcon;
  final bool? isObsecure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isObsecure ?? false,
        style: AppFontStyles.medium19,
        cursorColor: Get.isDarkMode ? Colors.white60 : Colors.black87,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppFontStyles.greyRegular17,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.all(20.sp),
            isDense: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.5.w, color: Colors.grey.withOpacity(.2)),
                borderRadius: BorderRadius.circular(30.sp)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.5.w, color: Colors.red.shade200),
                borderRadius: BorderRadius.circular(30.sp)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.5.w, color: Colors.grey.withOpacity(.2)),
                borderRadius: BorderRadius.circular(30.sp)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.5.w, color: Colors.grey.withOpacity(.2)),
                borderRadius: BorderRadius.circular(30.sp)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.sp),
              borderSide: BorderSide(width: 1.5.w, color: Colors.red),
            )),
      ),
    );
  }
}
