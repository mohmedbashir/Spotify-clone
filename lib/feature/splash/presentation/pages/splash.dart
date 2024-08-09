import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/utils/durations.dart';
import 'package:spotify/core/utils/assets/vectors.dart';
import 'package:spotify/feature/splash/presentation/pages/wrapper.dart';
// import 'package:spotify/feature/onBoarding/presentation/pages/on_boarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.hasSeenOnBording});

  final bool hasSeenOnBording;
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
        AppDurations.splash,
        () => Get.offAll(
              Wrapper(hasSeenOnBoarding: widget.hasSeenOnBording),
              transition: Transition.downToUp,
              duration: AppDurations.pageToPage,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SvgPicture.asset(AppVectors.logo),
    ));
  }
}
