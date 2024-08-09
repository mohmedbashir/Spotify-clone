import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/authentication/presentation/bloc/loading_cubit.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.label,
      this.height,
      this.width,
      // required this.state,
      this.elevation,
      this.isNotOnBordingButton,
      this.labelColor,
      this.background,
      // this.loading,
      this.loadingState,
      required this.onPressed});

  final String label;
  final double? height;
  final double? width;
  final LoadingState? loadingState;
  final VoidCallback onPressed;
  final bool? isNotOnBordingButton;
  final Color? background;
  final double? elevation;
  // final bool? loading;
  // final Color? splasColor;
  final Color? labelColor;
  // final OnboardingState state;

  @override
  Widget build(BuildContext context) {
    return isNotOnBordingButton ?? false
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                fixedSize:
                    Size(width?.w ?? Get.width * .7.w, height?.h ?? 70.h)),
            child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (Widget child,
                        Animation<double> animation) =>
                    Text(
                      label,
                      style: AppFontStyles.bold22.copyWith(color: Colors.white),
                    )),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                elevation: elevation,
                backgroundColor: background,
                fixedSize:
                    Size(width?.w ?? Get.width * .7.w, height?.h ?? 70.h)),
            child: loadingState is LoadingInProgress
                ? const CircularProgressIndicator.adaptive()
                : Text(
                    label,
                    style: AppFontStyles.medium19
                        .copyWith(color: labelColor ?? Colors.white),
                  ));
  }
}
