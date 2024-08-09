import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/assets/assets.dart';
import 'package:spotify/feature/onBoarding/presentation/widgets/first_page_content.dart';
import 'package:spotify/feature/onBoarding/presentation/widgets/second_page_content.dart';

part 'onboard_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
      : super(OnboardingState(
            buttonLabel: 'Get Started',
            backgroundImage: AppImages.onboard1,
            pageContent: FirstPageContent()));

  void nextStep() {
    emit(OnboardingState(
        buttonLabel: 'Continue',
        backgroundImage: AppImages.onboard2,
        pageContent: SecondPageContent()));
  }
}
