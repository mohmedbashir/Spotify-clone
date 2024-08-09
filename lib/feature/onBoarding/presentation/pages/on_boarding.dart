import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/assets/vectors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/onBoarding/presentation/widgets/bottom_button.dart';
import 'package:spotify/feature/onBoarding/presentation/widgets/custom_sliding_animation.dart';
import 'package:spotify/feature/onBoarding/presentation/bloc/on_board_cubit/onboard_cubit.dart';

// import 'package:spotify/core/utils/assets/assets.dart'
// import 'package:spotify/core/utils/theme/font_styles.dart';
// import 'package:spotify/feature/onBoarding/presentation/widgets/button.dart';
// import 'package:spotify/feature/onBoarding/presentation/widgets/first_page_content.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnboardingCubit(),
        child: const OnBoadingView(),
      ),
    );
  }
}

class OnBoadingView extends StatelessWidget {
  const OnBoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: AssetImage(state.backgroundImage))),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp),
              child: Column(
                children: [
                  verticalSpaceing(10),
                  SvgPicture.asset(AppVectors.logo),
                  const Spacer(),
                  CustomSlidingAnimation(child: state.pageContent),
                  verticalSpaceing(20),
                  BottomButton(state: state),
                  verticalSpaceing(10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
