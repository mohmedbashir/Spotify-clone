import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/utils/functions/save_auth_state.dart';
import 'package:spotify/feature/authentication/presentation/pages/welcome.dart';
import 'package:spotify/feature/onBoarding/presentation/widgets/custom_sliding_animation.dart';
import 'package:spotify/feature/onBoarding/presentation/bloc/on_board_cubit/onboard_cubit.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.state});

  final OnboardingState state;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (state.backgroundImage == AppImages.onboard1) {
            context.read<OnboardingCubit>().nextStep();
          } else {
            Get.offAll(AuthPage());
            await setHasSeenOnboarding();
            print("has seen the onboarding");
          }
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * .7.w, 70.h),
        ),
        child: CustomSlidingAnimation(
          child: Text(
            state.buttonLabel,
            key: ValueKey<String>(state.backgroundImage),
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
