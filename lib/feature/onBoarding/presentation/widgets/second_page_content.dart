import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/assets/vectors.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/onBoarding/presentation/bloc/theme_cubit/theme_cubit.dart';

class SecondPageContent extends StatelessWidget {
  const SecondPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Choose Mode",
          style: AppFontStyles.bold22.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        verticalSpaceing(20),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _chooseDarkMode(context, mode),
                _chooseLightMode(context, mode),
              ],
            );
          },
        ),
        verticalSpaceing(30),
      ],
    );
  }

  Column _chooseLightMode(BuildContext context, ThemeMode mode) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print("Theme toggled to light");
            context.read<ThemeCubit>().toggleTheme(ThemeMode.light);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.sp, sigmaY: 3.sp),
                  child: Container(
                    width: 60.sp,
                    height: 60.sp,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(mode == ThemeMode.light ? 0.8 : 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 23.sp,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(AppVectors.lightMode,
                    color: mode == ThemeMode.light ? Colors.black : null,
                    height: 50.h),
              ),
            ],
          ),
        ),
        verticalSpaceing(10),
        Text(
          "light Mode",
          style: AppFontStyles.regular17.copyWith(color: Colors.white),
        )
      ],
    );
  }

  Column _chooseDarkMode(BuildContext context, ThemeMode mode) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print("Theme toggled to dark");
            context.read<ThemeCubit>().toggleTheme(ThemeMode.dark);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.sp, sigmaY: 3.sp),
                  child: Container(
                    width: 60.sp,
                    height: 60.sp,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(mode == ThemeMode.dark ? 0.8 : 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 25.sp,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(AppVectors.darkMode,
                    color: mode == ThemeMode.dark ? Colors.black : null,
                    height: 50.h),
              ),
            ],
          ),
        ),
        verticalSpaceing(10),
        Text(
          "Dark Mode",
          style: AppFontStyles.regular17.copyWith(color: Colors.white),
        )
      ],
    );
  }
}
